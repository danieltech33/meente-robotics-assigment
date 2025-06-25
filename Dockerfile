FROM python:3.9-slim

WORKDIR /app

COPY hello_world.py .

# Set the script to be executable
RUN chmod +x hello_world.py

# Run the script when the container starts
CMD ["python", "hello_world.py"] 