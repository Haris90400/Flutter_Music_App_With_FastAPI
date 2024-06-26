from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = 'postgresql://postgres:<password>@localhost:5432/flutter_music_app'

# Create an SQLAlchemy engine instance to manage connections to the database
engine = create_engine(DATABASE_URL)

# Create a configured "Session" class which will serve as a factory for new Session objects
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


# Create a new Session instance from the configured Session class
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
