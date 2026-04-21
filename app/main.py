import os
import time
from typing import List

import psycopg2
from psycopg2.extras import RealDictCursor
from fastapi import FastAPI, Request, HTTPException, Query
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
import uvicorn

# Database configuration
DATABASE_URL = os.environ.get(
    "DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/faker"
)

app = FastAPI(
    title="Faker SQL",
    description="Generate deterministic fake user data using PostgreSQL stored procedures",
    version="2.0.0",
)

# Get template directory relative to this file
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
template_dir = os.path.join(BASE_DIR, "templates")
templates = Jinja2Templates(directory=template_dir)


def get_db_connection():
    """Get database connection."""
    return psycopg2.connect(DATABASE_URL, cursor_factory=RealDictCursor)


class FakeUser(BaseModel):
    """Fake user model."""

    row_index: int = 0
    full_name: str = ""
    address: str = ""
    latitude: float = 0.0
    longitude: float = 0.0
    height: str = "0"
    weight: str = "0"
    eye_color: str = "Unknown"
    phone: str = ""
    email: str = ""


def generate_users(
    locale: str, seed: int, batch_index: int, batch_size: int
) -> List[FakeUser]:
    """Call stored procedure to generate fake users."""
    with get_db_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute(
                """
                SELECT row_index, full_name, address, latitude, longitude, height, weight, eye_color, phone, email
                FROM sp_generate_fake_users(%s, %s, %s, %s)
            """,
                (locale, seed, batch_index, batch_size),
            )
            rows = cursor.fetchall()

            users = []
            for row in rows:
                r = dict(row)
                users.append(
                    FakeUser(
                        row_index=r.get("row_index", 0) or 0,
                        full_name=r.get("full_name", "") or "",
                        address=r.get("address", "") or "",
                        latitude=float(r.get("latitude", 0) or 0),
                        longitude=float(r.get("longitude", 0) or 0),
                        height=str(r.get("height", "0") or "0"),
                        weight=str(r.get("weight", "0") or "0"),
                        eye_color=str(r.get("eye_color", "Unknown") or "Unknown"),
                        phone=str(r.get("phone", "") or ""),
                        email=str(r.get("email", "") or ""),
                    )
                )
            return users


@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    """Render the main form."""
    with get_db_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT code, name, country FROM locales ORDER BY name")
            locales = cursor.fetchall()

    return templates.TemplateResponse(
        "index.html",
        {
            "request": request,
            "locales": locales,
            "default_locale": "uz_UZ",
            "default_seed": 12345,
            "default_batch_size": 10,
        },
    )


@app.get("/generate", response_class=HTMLResponse)
async def generate_get(
    request: Request,
    locale: str = Query("uz_UZ"),
    seed: int = Query(12345),
    batch_size: int = Query(10),
    batch_index: int = Query(0),
):
    """Generate fake users via GET for simplicity."""
    return await generate_users_view(request, locale, seed, batch_index, batch_size)


@app.post("/generate", response_class=HTMLResponse)
async def generate_post(request: Request):
    """Generate fake users via POST form submission."""
    form = await request.form()
    locale = form.get("locale", "uz_UZ")
    seed = int(form.get("seed", 12345))
    batch_size = int(form.get("batch_size", 10))
    action = form.get("action", "generate")
    current_batch_index = int(form.get("batch_index", 0))

    if action == "next":
        batch_index = current_batch_index + 1
    else:
        batch_index = 0

    return await generate_users_view(request, locale, seed, batch_index, batch_size)


async def generate_users_view(
    request: Request,
    locale: str,
    seed: int,
    batch_index: int,
    batch_size: int,
):
    """Shared function to generate and render users."""
    start_time = time.time()
    users = generate_users(locale, seed, batch_index, batch_size)
    elapsed = time.time() - start_time

    with get_db_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT code, name, country FROM locales ORDER BY name")
            locales = cursor.fetchall()

    return templates.TemplateResponse(
        "results.html",
        {
            "request": request,
            "users": users,
            "locales": locales,
            "locale": locale,
            "seed": seed,
            "batch_size": batch_size,
            "batch_index": batch_index,
            "elapsed": elapsed,
        },
    )


@app.get("/benchmark", response_class=HTMLResponse)
async def benchmark(request: Request, size: int = Query(10000)):
    """Run benchmark test."""
    locale = "uz_UZ"
    seed = 12345

    start_time = time.time()
    users = generate_users(locale, seed, 0, size)
    elapsed = time.time() - start_time

    users_per_sec = size / elapsed if elapsed > 0 else 0

    return templates.TemplateResponse(
        "benchmark.html",
        {
            "request": request,
            "total_users": size,
            "elapsed": elapsed,
            "users_per_sec": users_per_sec,
            "sample_users": users[:5],
        },
    )


@app.get("/health")
async def health():
    """Health check endpoint."""
    try:
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT 1 as health")
                result = cursor.fetchone()
        return {"status": "ok", "database": "connected"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
