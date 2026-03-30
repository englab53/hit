# Official 9Hits image ko base banayen
FROM 9hits/viewer:latest

# Render ko batane ke liye ke hum ek port use kar rahay hain (halankay viewer ko zaroorat nahi)
ENV PORT=10000
EXPOSE 10000

# Container ko batana ke setup kahan se start karna hai
# Note: Official image mein token environment variable 'token' (small letters) ho sakta hai
CMD ["./9hits-viewer", "--token=$TOKEN", "--allow-ssh"]
