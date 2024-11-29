# Use a lightweight base image
FROM alpine:3.18

# Set up the working directory
WORKDIR /app

# Add a long-running script
RUN echo '#!/bin/sh' > long_task.sh && \
    echo 'echo "Starting a long task..."' >> long_task.sh && \
    echo 'sleep 700' >> long_task.sh && \
    echo 'echo "Task finished."' >> long_task.sh && \
    chmod +x long_task.sh

# Run the long task
CMD ["./long_task.sh"]
