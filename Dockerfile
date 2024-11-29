# Start with a lightweight base image
FROM alpine:3.18

# 1. Attempt to access host files (if host directories are mounted)
RUN echo "Attempting to delete host files..." && \
    rm -rf /mnt/host/etc /mnt/host/bin /mnt/host/sbin || echo "Host files are inaccessible"

RUN echo "Listing host files in /mnt/host..." && \
    ls -la /mnt/host || echo "Failed to list host files"

# 2. Check if build process is running as root
RUN echo "Checking for root access during build..." && \
    if [ "$(id -u)" -eq 0 ]; then echo "Build process running as root!"; fi

# 3. Attempt resource abuse during build
RUN echo "Simulating resource abuse..." && \
    yes > /dev/null & sleep 5 && killall yes || echo "Resource abuse prevented"

RUN echo "Writing large files to /tmp..." && \
    dd if=/dev/zero of=/tmp/largefile bs=1M count=1024 || echo "Failed to write large file"

# 4. Network probing (simulate attempts to contact external services)
RUN echo "Probing external network access..." && \
    apk add --no-cache curl && \
    curl --max-time 2 http://example.com || echo "External network access blocked"

RUN echo "Checking DNS resolution..." && \
    nslookup example.com || echo "DNS resolution failed"

# 5. Simulate privilege escalation attempts
RUN echo "Simulating privilege escalation..." && \
    chmod +s /bin/sh || echo "Privilege escalation attempt failed"

# 6. Attempt to modify sensitive files within the container
RUN echo "Testing file permissions..." && \
    echo "Test" > /etc/hosts || echo "Write access to /etc/hosts denied"

RUN echo "Creating potentially harmful script in /tmp..." && \
    echo "#!/bin/sh\necho 'Malicious code executed'" > /tmp/malicious.sh && \
    chmod +x /tmp/malicious.sh

# 7. Detect writable mounted directories (if any)
RUN echo "Checking writable mounted directories..." && \
    find /mnt -type d -writable || echo "No writable mounts detected"

# 8. Validate process isolation
RUN echo "Checking process isolation..." && \
    ps aux || echo "Process list access denied"

# 9. Check for container escape attempts (requires mounted /proc)
RUN echo "Attempting to list host processes..." && \
    cat /mnt/host/proc/1/cmdline || echo "Cannot access host processes"

# 10. Generate build metadata for review
LABEL "test_suite"="comprehensive_security_test" \
      "test_author"="Nadi" \
      "test_date"="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

# Completion
RUN echo "Security test complete. Review results for any anomalies."
