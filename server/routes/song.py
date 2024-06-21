from fastapi import APIRouter, Depends, File, Form, UploadFile
from sqlalchemy.orm import Session

from database import get_db
from middleware.auth_middleware import auth_middleware

import cloudinary
import cloudinary.uploader

import uuid

import os
from dotenv import load_dotenv

load_dotenv()

API_KEY = os.getenv('API_KEY')
API_SECRET = os.getenv('API_SECRET')

print(f"API_KEY: {API_KEY}")
print(f"API_SECRET: {API_SECRET}")



# Configuration       
cloudinary.config( 
    cloud_name = "dz3g0oe8n", 
    api_key = API_KEY, 
    api_secret = API_SECRET, # Click 'View Credentials' below to copy your API secret
    secure=True
)



router = APIRouter()

@router.post('/upload')
def upload_songs(song:UploadFile = File(...),
                 thumbnail:UploadFile = File(...),
                 artist:str = Form(...),
                 song_name:str = Form(...),
                 hex_code:str = Form(...),
                 db:Session = Depends(get_db),
                 auth_dict = Depends(auth_middleware)):
    
    song_id = str(uuid.uuid4())
    song_res = cloudinary.uploader.upload(song.file,resource_type="auto",folder=f'songs/{song_id}')
    print(song_res)
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file,resource_type="image",folder=f'songs/{song_id}')
    print(thumbnail_res)

    return 'ok'