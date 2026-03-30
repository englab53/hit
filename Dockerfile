FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    wget unzip libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 \
    libxkbcommon0 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
    libxrandr2 libgbm1 libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 9Hits V4 Headless (More stable for Render)
RUN wget --user-agent="Mozilla/5.0" https://9hits.com/downloads/9hits-viewer-linux-x64.zip && \
    unzip 9hits-viewer-linux-x64.zip && \
    rm 9hits-viewer-linux-x64.zip

RUN chmod +x 9hits-viewer

# Render port binding
EXPOSE 10000

# TOKEN variable ko Render ke dashboard mein set karen
CMD ./9hits-viewer --token=$TOKEN --allow-ssh
