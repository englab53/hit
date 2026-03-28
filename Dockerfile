# Step 1: Lightweight base image
FROM debian:bullseye-slim

# Step 2: Browser dependencies install karein (Zaroori for 9Hits)
RUN apt-get update && apt-get install -y \
    wget bzip2 libnss3 libatk1.0-0 libatk-bridge2.0-0 \
    libcups2 libdrm2 libxkbcommon0 libxcomposite1 \
    libxdamage1 libxrandr2 libgbm1 libasound2 python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Step 3: 9Hits Viewer Download aur Extract
RUN wget -q https://9hits.com/tools/9hits-viewer-linux-x64.tar.bz2 && \
    tar -xjvf 9hits-viewer-linux-x64.tar.bz2 && \
    rm 9hits-viewer-linux-x64.tar.bz2

# --- CONFIGURATION (Direct ya Environment Variables se set karein) ---
# Yahan apna Token dalein ya Render ke dashboard mein TOKEN variable banayein
ENV TOKEN=YOUR_9HITS_TOKEN_HERE
ENV SESSIONS=1
ENV NOTE=Render_Miner_Single
ENV PORT=10000

# Step 4: Render ko "Live" rakhne ke liye aik simple server
# Ye command Render ki port 10000 ko active rakhegi
RUN echo "import socket; s = socket.socket(); s.bind(('0.0.0.0', 10000)); s.listen(1); \
    while True: c, a = s.accept(); c.send(b'HTTP/1.1 200 OK\n\nMiner is Running'); c.close()" > keep_alive.py

# Step 5: Dono (Keep-Alive aur 9Hits) ko aik sath chalana
CMD python3 keep_alive.py & ./9hits-viewer --token=$TOKEN --sessions=$SESSIONS --note=$NOTE --allow-adult=yes
