# Lightweight Linux base
FROM debian:bullseye-slim

# Install dependencies (Minimal for headless browser)
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# 9Hits Viewer download aur setup
WORKDIR /app
RUN wget https://9hits.com/downloads/9hits-viewer-linux-x64.zip && \
    unzip 9hits-viewer-linux-x64.zip && \
    rm 9hits-viewer-linux-x64.zip

# Execute permission
RUN chmod +x 9hits-viewer

# Default command (Token environment variable se ayega)
CMD ["./9hits-viewer", "--token=$TOKEN", "--allow-ssh"]
