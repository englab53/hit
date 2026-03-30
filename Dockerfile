FROM debian:bullseye-slim
# Dependencies install karen (pehle wali list)
RUN apt-get update && apt-get install -y ... 

WORKDIR /app
# GitHub se direct copy karen
COPY 9hits-viewer .
RUN chmod +x 9hits-viewer

CMD ["./9hits-viewer", "--token=$TOKEN", "--allow-ssh"]
