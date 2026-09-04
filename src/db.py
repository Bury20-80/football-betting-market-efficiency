from pathlib import Path
import os

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import URL


def create_db_engine(repo_root):
    """Create the project PostgreSQL engine from the repository .env file."""
    repo_root = Path(repo_root).resolve()
    env_path = repo_root / ".env"

    if not env_path.exists():
        raise FileNotFoundError(
            f".env file not found at {env_path}. "
            "Create it in the repository root before running SQL-backed notebooks."
        )

    load_dotenv(env_path)

    config = {
        "DB_HOST": os.getenv("DB_HOST"),
        "DB_PORT": os.getenv("DB_PORT"),
        "DB_NAME": os.getenv("DB_NAME"),
        "DB_USER": os.getenv("DB_USER"),
        "DB_PASSWORD": os.getenv("DB_PASSWORD"),
    }

    required = ["DB_HOST", "DB_PORT", "DB_NAME", "DB_USER"]
    missing = [name for name in required if not config[name]]

    if missing:
        raise EnvironmentError(
            "Missing required variables in .env: " + ", ".join(missing)
        )

    database_url = URL.create(
        drivername="postgresql+psycopg2",
        username=config["DB_USER"],
        password=config["DB_PASSWORD"],
        host=config["DB_HOST"],
        port=int(config["DB_PORT"]),
        database=config["DB_NAME"],
    )

    return create_engine(database_url, pool_pre_ping=True)
