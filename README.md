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

## CI/CD Pipeline

[![Deploy to AWS ECR and Lambda](https://github.com/meente-robotics-assigmenteltech33/meente-robotics-assigment/actions/workflows/main.yml/badge.svg)](https://github.com/meente-robotics-assigmenteltech33/meente-robotics-assigment/actions/workflows/main.yml)

This project includes a CI/CD pipeline using GitHub Actions that automates the deployment process to AWS.

### Pipeline Steps

When code is pushed to the `main` branch, the pipeline will:
1.  **Build** a Docker image of the Python application.
2.  **Push** the image to the Amazon ECR repository named `meente-robotics-assigment-ecr`.
3.  **Update** the AWS Lambda function `meente-robotics-assigment-lambda` with the new image.

### Setup

For the pipeline to run successfully, you need to configure secrets in your GitHub repository.

1.  Go to your repository's **Settings** > **Secrets and variables** > **Actions**.
2.  Create the following two repository secrets:
    *   `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
    *   `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.

The IAM user for these credentials needs permissions to push to ECR and update the Lambda function. Here is an example policy:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowECRAccess",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:CompleteLayerUpload",
                "ecr:InitiateLayerUpload",
                "ecr:PutImage",
                "ecr:UploadLayerPart"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowLambdaUpdate",
            "Effect": "Allow",
            "Action": "lambda:UpdateFunctionCode",
            "Resource": "arn:aws:lambda:eu-north-1:485701710361:function:meente-robotics-assigment-lambda"
        }
    ]
}
```
