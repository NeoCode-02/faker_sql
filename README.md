# Faker SQL v2

Generate deterministic fake user data using PostgreSQL stored procedures.

## Quick Start

### Using Docker (Recommended)

```bash
cd /home/light/Downloads/data_engineering/fake_data/faker_sql_v2

# Start services (SQL files auto-run alphabetically on first boot via docker-entrypoint-initdb.d)
docker-compose up -d

# Open app
# http://localhost:8000
```

### Local Development

1. Install PostgreSQL 15+
2. Run SQL scripts in order:
   - `sql/01_schema.sql`
   - `sql/02_functions.sql`
   - `sql/03_generators.sql`
   - `sql/04_procedures.sql`
   - `sql/05_seed.sql`

3. Install Python dependencies:
```bash
pip install fastapi uvicorn psycopg2-binary jinja2
```

4. Set database URL:
```bash
export DATABASE_URL=postgresql://postgres:postgres@localhost:5432/faker
```

5. Run app:
```bash
cd app
python main.py
```

## Usage

### Web Interface

1. Open http://localhost:8000
2. Select locale (uz_UZ or ru_RU)
3. Enter seed value
4. Click Generate

### API Usage

```python
from app.main import generate_users

users = generate_users(
    locale="uz_UZ",
    seed=12345,
    batch_index=0,
    batch_size=10
)

for user in users:
    print(user.full_name, user.email)
```

### Direct SQL

```sql
-- Generate 10 users
SELECT * FROM sp_generate_fake_users('uz_UZ', 12345, 0, 10);

-- Next batch
SELECT * FROM sp_generate_fake_users('uz_UZ', 12345, 1, 10);

-- Benchmark
\timing
SELECT * FROM sp_generate_fake_users('uz_UZ', 12345, 0, 100000);
```

## Features

- **Deterministic**: Same inputs → same outputs
- **Reproducible**: Seed + batch index ensures reproducibility
- **Extensible**: Add new locales by inserting into lookup tables
- **Performant**: ~2000 users/second

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| GET / | Main form |
| POST /generate | Generate users |
| GET /benchmark | Performance test |
| GET /health | Health check |

## Configuration

Environment variables:
- `DATABASE_URL`: PostgreSQL connection string
- Default: `postgresql://postgres:postgres@localhost:5432/faker`

## Project Structure

```
faker_sql_v2/
├── app/
│   ├── main.py          # FastAPI application
│   └── templates/      # HTML templates
├── sql/
│   ├── 01_schema.sql     # Database schema
│   ├── 02_functions.sql  # Core random functions
│   ├── 03_generators.sql # Field generators
│   ├── 04_procedures.sql # Main procedure
│   └── 05_seed.sql       # Lookup data
├── docs/
│   └── sql_library.md # Function documentation
├── docker-compose.yml
├── Dockerfile
└── README.md
```

## License

MIT