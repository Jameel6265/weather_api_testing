# Dockerfile

# --- Stage 1: The Builder ---
# This stage installs dependencies into a virtual environment.
FROM python:3.9-slim-bookworm AS builder

WORKDIR /opt/venv
RUN python -m venv .
ENV PATH="/opt/venv/bin:$PATH"

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# --- Stage 2: The Final Image ---
# This stage creates the final, lean image.
FROM python:3.9-slim-bookworm

WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder /opt/venv /opt/venv

# Copy the application source code
COPY src/ ./src/

# Set the PATH to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Set the entrypoint for the container
CMD ["pytest", "src/"]