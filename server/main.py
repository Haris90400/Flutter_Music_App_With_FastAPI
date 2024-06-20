from fastapi import FastAPI
from models.base import Base
from routes import auth
from database import engine
import uvicorn

# Initialize a FastAPI application instance
app = FastAPI()

app.include_router(auth.router,prefix='/auth')


Base.metadata.create_all(engine)

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)