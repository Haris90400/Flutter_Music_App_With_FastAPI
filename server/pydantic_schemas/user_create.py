# Define a Pydantic model for the user creation request
from pydantic import BaseModel


class UserCreate(BaseModel):
    name: str  # Field for the user's name
    email: str  # Field for the user's email
    password: str  # Field for the user's password