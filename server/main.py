from fastapi import FastAPI
from models.base import Base
from routes import auth,song
from database import engine
import uvicorn

# Initialize a FastAPI application instance
app = FastAPI()

app.include_router(auth.router,prefix='/auth')
app.include_router(song.router,prefix='/songs')


Base.metadata.create_all(engine)

