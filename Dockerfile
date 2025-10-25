# Dockerfile for Railway — simple and forgiving for messy repo layouts
FROM python:3.10-slim

WORKDIR /app

# Copy everything into container (works even if files are nested)
COPY . .

# Minimal base install so flask/gunicorn exist even if requirements missing
RUN pip install --no-cache-dir flask gunicorn || true

# If a requirements.txt exists at repo root, install from it
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

ENV PORT=8080

# Update this line if your filename or app variable is different:
# For app.py with `app = Flask(__name__)` -> use app:app
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080", "--workers", "2"]
