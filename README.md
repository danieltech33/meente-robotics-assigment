# meente-robotics-assigment

A simple hello world code with semantic versioning.

## Hello World Python Script

A simple Python script that prints "Hello, World!" to the console.

## Local Usage

```bash
python hello_world.py
```

Or make it executable and run directly:

```bash
chmod +x hello_world.py
./hello_world.py
```

## Docker Usage

### Build the Docker image
```bash
docker build -t hello-world-python .
```

### Run the Docker container
```bash
docker run hello-world-python
```

## AWS ECR Deployment

1. Authenticate Docker to your AWS ECR registry:
```bash
aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com
```

2. Create a repository in ECR (if not already created):
```bash
aws ecr create-repository --repository-name hello-world-python --region your-region
```

3. Tag your Docker image for ECR:
```bash
docker tag hello-world-python:latest your-account-id.dkr.ecr.your-region.amazonaws.com/hello-world-python:latest
```

4. Push the image to ECR:
```bash
docker push your-account-id.dkr.ecr.your-region.amazonaws.com/hello-world-python:latest
```
