FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir \
    fastapi==0.109.0 \
    uvicorn==0.27.0 \
    psycopg2-binary \
    jinja2==3.1.3 \
    python-multipart==0.0.9 \
    starlette==0.35.0

COPY app /app/app

ENV PYTHONPATH=/app
ENV DATABASE_URL=postgresql://postgres:postgres@postgres:5432/faker

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
