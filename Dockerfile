# Stage 1: Build the binary
FROM python:3.12-slim AS builder
WORKDIR /app
COPY app.py .

# Install required system tools (binutils) and PyInstaller
RUN apt-get update && apt-get install -y --no-install-recommends binutils \
    && pip install --no-cache-dir pyinstaller \
    && pyinstaller --onefile app.py \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Stage 2: Runtime (use a smaller image)
FROM ubuntu:24.04
WORKDIR /app
COPY --from=builder /app/dist/app /app/app

CMD ["./app"]

