#!/usr/bin/env python3
"""
Knowledge Assistant Dashboard - Backend Server
Zero external dependencies - only Python stdlib required.
Run with: python3 dashboard/server.py
Access at: http://localhost:8765
"""

import http.server
import json
import subprocess
import os
import sys
import platform
import threading
import socketserver
from urllib.parse import urlparse, parse_qs
from pathlib import Path
import datetime

PORT = 8765
IS_WINDOWS = platform.system() == "Windows"

# Resolve project root (parent of dashboard/)
DASHBOARD_DIR = Path(__file__).parent.resolve()
PROJECT_DIR   = DASHBOARD_DIR.parent.resolve()
DOCS_DIR      = PROJECT_DIR / "docs"
SCRIPTS_DIR   = PROJECT_DIR / "scripts"
BACKUPS_DIR   = PROJECT_DIR / "backups"


# ─────────────────────────────────────────────
#  Helpers
# ─────────────────────────────────────────────

def run_cmd(args, cwd=None, timeout=30):
    """Run a command, return (stdout, stderr, returncode)."""
    try:
        result = subprocess.run(
            args,
            capture_output=True,
            text=True,
            cwd=str(cwd or PROJECT_DIR),
            timeout=timeout,
            shell=IS_WINDOWS,  # needed on Windows for built-ins
        )
        return result.stdout.strip(), result.stderr.strip(), result.returncode
    except subprocess.TimeoutExpired:
        return "", "Timeout expired", 1
    except Exception as e:
        return "", str(e), 1


def json_response(handler, data, status=200):
    body = json.dumps(data, ensure_ascii=False).encode()
    handler.send_response(status)
    handler.send_header("Content-Type", "application/json; charset=utf-8")
    handler.send_header("Content-Length", str(len(body)))
    handler.send_header("Access-Control-Allow-Origin", "*")
    handler.end_headers()
    handler.wfile.write(body)


def text_response(handler, text, status=200, content_type="text/plain; charset=utf-8"):
    body = text.encode("utf-8", errors="replace")
    handler.send_response(status)
    handler.send_header("Content-Type", content_type)
    handler.send_header("Content-Length", str(len(body)))
    handler.send_header("Access-Control-Allow-Origin", "*")
    handler.end_headers()
    handler.wfile.write(body)


def read_body(handler):
    length = int(handler.headers.get("Content-Length", 0))
    return json.loads(handler.rfile.read(length)) if length else {}


# ─────────────────────────────────────────────
#  API handlers
# ─────────────────────────────────────────────

def api_status():
    """Return running containers info."""
    stdout, _, _ = run_cmd([
        "docker", "ps",
        "--filter", "name=ollama",
        "--filter", "name=open-webui",
        "--format", "{{json .}}"
    ])
    containers = []
    for line in stdout.splitlines():
        line = line.strip()
        if line:
            try:
                containers.append(json.loads(line))
            except Exception:
                pass
    ollama_up  = any("ollama"    in c.get("Names","") for c in containers)
    webui_up   = any("open-webui" in c.get("Names","") for c in containers)
    return {
        "containers": containers,
        "ollama": ollama_up,
        "open_webui": webui_up,
        "timestamp": datetime.datetime.now().isoformat()
    }


def api_models():
    """List installed models (Docker or native Ollama)."""
    stdout, _, rc = run_cmd(["docker", "exec", "ollama", "ollama", "list"])
    source = "docker"
    if rc != 0:
        stdout, _, rc = run_cmd(["ollama", "list"])
        source = "native"
    if rc != 0:
        return {"models": [], "source": "none", "error": "Ollama not reachable"}

    models = []
    lines = stdout.strip().splitlines()
    for line in lines[1:]:          # skip header
        parts = line.split()
        if parts:
            models.append({
                "name": parts[0],
                "id":   parts[1] if len(parts) > 1 else "",
                "size": parts[2] if len(parts) > 2 else "",
                "modified": " ".join(parts[3:]) if len(parts) > 3 else ""
            })
    return {"models": models, "source": source}


def api_start_full():
    stdout, stderr, rc = run_cmd([
        "docker", "compose", "-f", "docker-compose.full.yml", "up", "-d"
    ], timeout=120)
    return {
        "ok": rc == 0,
        "output": stdout or stderr,
        "mode": "full"
    }


def api_start_hybrid():
    stdout, stderr, rc = run_cmd([
        "docker", "compose", "-f", "docker-compose.hybrid.yml", "up", "-d"
    ], timeout=120)
    return {
        "ok": rc == 0,
        "output": stdout or stderr,
        "mode": "hybrid"
    }


def api_stop():
    out1, err1, rc1 = run_cmd([
        "docker", "compose", "-f", "docker-compose.full.yml", "down"
    ], timeout=60)
    out2, err2, rc2 = run_cmd([
        "docker", "compose", "-f", "docker-compose.hybrid.yml", "down"
    ], timeout=60)
    combined = "\n".join(filter(None, [out1, err1, out2, err2]))
    return {
        "ok": True,
        "output": combined or "Tutti i servizi fermati."
    }


def api_pull_model(model_name):
    if not model_name:
        return {"ok": False, "output": "Nome modello mancante"}

    # Try Docker container first
    stdout, _, rc = run_cmd(
        ["docker", "ps", "--filter", "name=ollama", "--format", "{{.Names}}"]
    )
    if "ollama" in stdout:
        out, err, rc = run_cmd(
            ["docker", "exec", "ollama", "ollama", "pull", model_name],
            timeout=600
        )
    else:
        out, err, rc = run_cmd(
            ["ollama", "pull", model_name],
            timeout=600
        )
    return {
        "ok": rc == 0,
        "output": out or err or f"Pull di '{model_name}' completato."
    }


def api_backup():
    BACKUPS_DIR.mkdir(exist_ok=True)
    date_str = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = f"openwebui-backup-{date_str}.tar.gz"
    backup_path = BACKUPS_DIR / backup_file

    out, err, rc = run_cmd([
        "docker", "run", "--rm",
        "-v", "open-webui:/data",
        "-v", f"{BACKUPS_DIR}:/backup",
        "alpine",
        "tar", "czf", f"/backup/{backup_file}", "/data"
    ], timeout=300)

    if rc != 0:
        return {"ok": False, "output": err or "Backup fallito"}

    size = ""
    if backup_path.exists():
        size_bytes = backup_path.stat().st_size
        if size_bytes > 1_073_741_824:
            size = f"{size_bytes/1_073_741_824:.2f} GB"
        elif size_bytes > 1_048_576:
            size = f"{size_bytes/1_048_576:.2f} MB"
        else:
            size = f"{size_bytes} B"

    return {
        "ok": True,
        "file": backup_file,
        "size": size,
        "output": f"Backup completato: {backup_file} ({size})"
    }


def api_test():
    """Run 5 diagnostic checks."""
    checks = []

    # CHECK 1: Docker installed
    _, _, rc = run_cmd(["docker", "--version"])
    checks.append({"id": 1, "label": "Docker installato", "ok": rc == 0})

    # CHECK 2: Docker running
    _, _, rc = run_cmd(["docker", "info"])
    checks.append({"id": 2, "label": "Docker Desktop in esecuzione", "ok": rc == 0})

    # CHECK 3: open-webui container
    stdout, _, _ = run_cmd([
        "docker", "ps", "--filter", "name=open-webui", "--format", "{{.Names}}"
    ])
    checks.append({"id": 3, "label": "Container Open WebUI attivo", "ok": "open-webui" in stdout})

    # CHECK 4: Ollama reachable (docker or native)
    stdout, _, _ = run_cmd([
        "docker", "ps", "--filter", "name=ollama", "--format", "{{.Names}}"
    ])
    ollama_ok = "ollama" in stdout
    if not ollama_ok:
        import urllib.request
        try:
            urllib.request.urlopen("http://localhost:11434", timeout=5)
            ollama_ok = True
        except Exception:
            pass
    checks.append({"id": 4, "label": "Ollama raggiungibile", "ok": ollama_ok})

    # CHECK 5: At least one model
    out, _, rc = run_cmd(["docker", "exec", "ollama", "ollama", "list"])
    if rc != 0:
        out, _, rc = run_cmd(["ollama", "list"])
    lines = [l for l in out.splitlines() if l.strip()]
    has_model = len(lines) > 1  # header + at least 1
    checks.append({"id": 5, "label": "Almeno un modello disponibile", "ok": has_model})

    passed = sum(1 for c in checks if c["ok"])
    return {"checks": checks, "passed": passed, "total": len(checks)}


def api_docs(filename):
    """Read a doc file and return its content."""
    safe = Path(filename).name          # prevent path traversal
    candidates = [
        DOCS_DIR / safe,
        PROJECT_DIR / safe,
    ]
    for path in candidates:
        if path.exists():
            return {
                "ok": True,
                "filename": safe,
                "content": path.read_text(encoding="utf-8", errors="replace"),
                "ext": path.suffix.lower()
            }
    return {"ok": False, "content": f"File non trovato: {safe}"}


def api_logs_list():
    """List available compose services for log streaming."""
    services = []
    for fname in ["docker-compose.full.yml", "docker-compose.hybrid.yml"]:
        p = PROJECT_DIR / fname
        if p.exists():
            services.append(fname)
    return {"services": services}


# ─────────────────────────────────────────────
#  HTTP Handler
# ─────────────────────────────────────────────

class DashboardHandler(http.server.BaseHTTPRequestHandler):

    def log_message(self, fmt, *args):
        # Quieter logging — skip SSE stream noise
        first = str(args[0]) if args else ""
        if "/api/logs/stream" not in first:
            super().log_message(fmt, *args)

    def do_OPTIONS(self):
        self.send_response(204)
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")
        self.end_headers()

    def do_GET(self):
        parsed = urlparse(self.path)
        path   = parsed.path.rstrip("/") or "/"

        if path == "/":
            self._serve_file(DASHBOARD_DIR / "index.html", "text/html; charset=utf-8")

        elif path == "/api/status":
            json_response(self, api_status())

        elif path == "/api/models":
            json_response(self, api_models())

        elif path == "/api/test":
            json_response(self, api_test())

        elif path == "/api/backup/list":
            files = []
            if BACKUPS_DIR.exists():
                for f in sorted(BACKUPS_DIR.glob("*.tar.gz"), reverse=True):
                    files.append({
                        "name": f.name,
                        "size": f"{f.stat().st_size/1_048_576:.1f} MB",
                        "date": datetime.datetime.fromtimestamp(f.stat().st_mtime).strftime("%Y-%m-%d %H:%M")
                    })
            json_response(self, {"files": files})

        elif path == "/api/logs/stream":
            qs     = parse_qs(parsed.query)
            svc    = qs.get("service", ["all"])[0]
            target = qs.get("target", ["full"])[0]
            self._stream_logs(svc, target)

        elif path.startswith("/api/docs/"):
            filename = path[len("/api/docs/"):]
            json_response(self, api_docs(filename))

        else:
            self.send_error(404, "Not found")

    def do_POST(self):
        parsed = urlparse(self.path)
        path   = parsed.path.rstrip("/")

        if path == "/api/start-full":
            json_response(self, api_start_full())

        elif path == "/api/start-hybrid":
            json_response(self, api_start_hybrid())

        elif path == "/api/stop":
            json_response(self, api_stop())

        elif path == "/api/pull-model":
            body = read_body(self)
            json_response(self, api_pull_model(body.get("model", "")))

        elif path == "/api/backup":
            json_response(self, api_backup())

        else:
            self.send_error(404, "Not found")

    # ── SSE log streaming ───────────────────

    def _stream_logs(self, service, target):
        compose_file = f"docker-compose.{'hybrid' if target == 'hybrid' else 'full'}.yml"
        cmd = ["docker", "compose", "-f", compose_file, "logs", "-f", "--tail=100"]
        if service != "all":
            cmd.append(service)

        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream")
        self.send_header("Cache-Control", "no-cache")
        self.send_header("Connection", "keep-alive")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("X-Accel-Buffering", "no")
        self.end_headers()

        try:
            proc = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                cwd=str(PROJECT_DIR),
                shell=IS_WINDOWS,
            )
            for raw in iter(proc.stdout.readline, b""):
                line = raw.decode("utf-8", errors="replace").rstrip()
                msg  = f"data: {json.dumps(line)}\n\n"
                self.wfile.write(msg.encode())
                self.wfile.flush()
            proc.wait()
        except (BrokenPipeError, ConnectionResetError):
            pass
        except Exception as e:
            try:
                self.wfile.write(f"data: {json.dumps(f'[ERROR] {e}')}\n\n".encode())
            except Exception:
                pass
        finally:
            try:
                proc.kill()
            except Exception:
                pass

    # ── Static file serving ─────────────────

    def _serve_file(self, path, content_type):
        if not path.exists():
            self.send_error(404, f"File not found: {path.name}")
            return
        body = path.read_bytes()
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


# ─────────────────────────────────────────────
#  Threaded server (needed for SSE + normal reqs)
# ─────────────────────────────────────────────

class ThreadedHTTPServer(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True


# ─────────────────────────────────────────────
#  Entry point
# ─────────────────────────────────────────────

def main():
    print(f"""
╔══════════════════════════════════════════╗
║  Knowledge Assistant Dashboard           ║
║  Porta: {PORT}  -  http://localhost:{PORT}   ║
║  Project: {str(PROJECT_DIR)[:40]}
║  Premi Ctrl+C per fermare il server      ║
╚══════════════════════════════════════════╝
""")
    server = ThreadedHTTPServer(("127.0.0.1", PORT), DashboardHandler)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer fermato.")


if __name__ == "__main__":
    main()
