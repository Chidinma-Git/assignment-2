# Assignment 2 — Dockerized Diagnostic CLI

A lightweight Bash-based diagnostic CLI packaged in a Docker container.

The project provides simple commands for checking system information,
disk usage, and network connectivity.

## Features

- System diagnostics
- Disk usage diagnostics
- Network connectivity checks
- Dockerized Bash CLI
- Docker Compose support
- Container health check
- Automated test suite
- Local grading script

## Project Structure

```text
assignment-2/
├── README.md
├── Dockerfile
├── compose.yaml
├── .dockerignore
├── test.sh
├── grade.sh
└── app/
    ├── diagnostic.sh
    └── health-check.sh



Requirements
- Docker
- Docker Compose
- Bash
- Git
CLI Usage
Help: docker run --rm diagnostic-tool help

System diagnostics
docker run --rm diagnostic-tool system
Disk diagnostics
docker run --rm diagnostic-tool disk
Network diagnostics
docker run --rm diagnostic-tool network localhost
Docker Build
Build the image:
docker build -t diagnostic-tool .
Run the image:
docker run --rm diagnostic-tool help
Docker Compose
The project also supports Docker Compose.
Run the help command:
docker compose run --rm diagnostic help
Run system diagnostics:
docker compose run --rm diagnostic system
Run disk diagnostics:
docker compose run --rm diagnostic disk
Run network diagnostics:
docker compose run --rm diagnostic network localhost
Health Check
Run the health check locally:
./app/health-check.sh
Run it inside the container:
docker run --rm \
  --entrypoint /app/health-check.sh \
  diagnostic-tool
The health check verifies that required tools are available and that
the diagnostic CLI is executable.
Testing
The project includes an automated test script.
Make it executable:
chmod +x test.sh
Run:
./test.sh
The test suite checks:
- Docker image builds successfully
- Help command works
- System command works
- Disk command works
- Network command works
- Invalid commands return a non-zero exit code
- Health check works
Grading
Run the local grading script:
chmod +x grade.sh
./grade.sh
The grading script checks the required project files, Bash syntax,
permissions, Docker build, Docker commands, Compose configuration,
and the student test suite.
Exit Codes
Code	Meaning
0	Command completed successfully
2	Invalid command or invalid input
1	Diagnostic or runtime failure


Docker Image
The project uses Alpine Linux as a lightweight base image.
The Docker image installs the tools required by the diagnostic
scripts and copies the application into /app.
Assumptions
- Docker Desktop is installed and running.
- Network tests depend on the container's network environment.
- The project is intended for local development and learning.

