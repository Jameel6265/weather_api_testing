# --- Stage 1: Builder ---
FROM python:3.9-slim-bookworm AS builder

WORKDIR /opt/venv
RUN python -m venv .
ENV PATH="/opt/venv/bin:$PATH"

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# --- Stage 2: Final Image ---
FROM python:3.9-slim-bookworm

WORKDIR /app

# Copy the virtual environment from builder
COPY --from=builder /opt/venv /opt/venv

# Copy the application source code
COPY src/ ./src/

# Set PATH to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Run tests by default (can be overridden in Jenkins)
CMD ["pytest", "src/"]
