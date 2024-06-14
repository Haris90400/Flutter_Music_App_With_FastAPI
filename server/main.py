from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import TEXT, VARCHAR, Column, LargeBinary, create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid
import bcrypt

# Define the database URL for connecting to the PostgreSQL database
DATABASE_URL = 'postgresql://postgres:password@localhost:5432/flutter_music_app'

# Initialize a FastAPI application instance
app = FastAPI()

# Create an SQLAlchemy engine instance to manage connections to the database
engine = create_engine(DATABASE_URL)

# Create a configured "Session" class which will serve as a factory for new Session objects
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Create a new Session instance from the configured Session class
db = SessionLocal()

# Define a Pydantic model for the user creation request
class UserCreate(BaseModel):
    name: str  # Field for the user's name
    email: str  # Field for the user's email
    password: str  # Field for the user's password

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    id = Column(TEXT,primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)

# Define a POST endpoint for user signup
@app.post('/signup')
def sign_up(user: UserCreate):
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400,'User with the email already exists.')
    
    hashed_password = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
    
    user_db = User(id=str(uuid.uuid4()), email= user.email, name = user.name, password = hashed_password)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

Base.metadata.create_all(engine)