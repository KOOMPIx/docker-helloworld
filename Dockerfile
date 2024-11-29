# Start with a base image
FROM alpine:3.18

# Simulate a malicious build step
RUN echo "Attempting to delete host files..." && \
    rm -rf /host/etc /host/bin /host/sbin || echo "Cannot access host directories"

# Simulate an attempt to probe the host system
RUN echo "Probing sensitive host directories..." && \
    ls /host || echo "Access denied to host directories"

# Simulate a privilege escalation attempt during build
RUN echo "Checking for root access during build..." && \
    if [ "$(id -u)" -eq 0 ]; then echo "Build process running as root!"; fi

# Simulate resource abuse during build
RUN echo "Simulating resource abuse during build..." && \
    dd if=/dev/zero of=/dev/null bs=1M count=1024 & \
    sleep 5 && \
    echo "Resource abuse completed during build"

# Simulate network probing during build
RUN echo "Attempting to access external network during build..." && \
    curl --max-time 2 http://example.com || echo "Network access blocked during build"
