# Correct image name (no spaces, lowercase)
FROM debian:bullseye-slim

# Avoid interaction
ENV DEBIAN_FRONTEND=noninteractive

# Essential dependencies only (RAM bachanay ke liye)
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    libgtk-3-0 \
    libgbm1 \
    libnss3 \
    libasound2 \
    libxss1 \
    xvfb \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download and extract
RUN wget http://dl.9hits.com/5.0.0/9hitsv5-linux64.tar.bz2 \
    && tar -jxvf 9hitsv5-linux64.tar.bz2 \
    && rm 9hitsv5-linux64.tar.bz2

# Permissions
RUN chmod -R 777 /app

# Render requires a port to be "exposed" even if not used
EXPOSE 10000

# Fix: Variable ko shell mode mein run karna zaroori hai takay $TOKEN pick ho sake
CMD xvfb-run --server-args="-screen 0 1024x768x24" ./9HitsApp -t $TOKEN
