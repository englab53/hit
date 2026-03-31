FROM 9hitste/app:latest

USER root

# Step 1: Python aur zaroori tools install karen status page ke liye
RUN apt-get update && apt-get install -y python3 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Step 2: Aik simple Status Page (index.html) banayein
RUN echo '<!DOCTYPE html>\
<html>\
<head>\
    <title>9Hits Status Dashboard</title>\
    <style>\
        body { font-family: sans-serif; background: #1a1a1a; color: #00ff00; text-align: center; padding-top: 50px; }\
        .status { font-size: 24px; border: 2px solid #00ff00; display: inline-block; padding: 20px; border-radius: 10px; }\
        .info { color: #888; margin-top: 20px; }\
    </style>\
</head>\
<body>\
    <h1>🚀 9Hits is Running on Hugging Face</h1>\
    <div class="status">Status: ACTIVE ✅</div>\
    <p class="info">RAM: 16GB | Sessions: Active in Background</p>\
    <p>Check your 9Hits Dashboard to see live credits.</p>\
    <script>setTimeout(function(){ location.reload(); }, 30000);</script>\
</body>\
</html>' > index.html

# Step 3: Hugging Face port
EXPOSE 10000

# Step 4: Background mein 9Hits aur Foreground mein Web Server chalayen
# Is se port 7860 busy rahay ga aur Space kabhi band nahi hogi
CMD /nh.sh --token=$TOKEN --system-session --ex-proxy-sessions=1 --allow-crypto=no --session-note=9hits-pool --note=HF-Space --hide-browser & python3 -m http.server 7860
