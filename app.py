from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 5000

class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Hello from Ry custom Docker image!")

if __name__ == "__main__":
    with HTTPServer(("0.0.0.0", PORT), MyHandler) as server:
        print(f"Serving on port {PORT}...")
        server.serve_forever()
