import uuid
import bcrypt
from fastapi import Depends, HTTPException

from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter

from pydantic_schemas.user_login import UserLogin

import jwt


router = APIRouter()

@router.post('/signup',status_code=201)
def sign_up(user: UserCreate,db=Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()

    if user_db:
        raise HTTPException(400,'User with the email already exists.')
    
    hashed_password = bcrypt.hashpw(user.password.encode(),bcrypt.gensalt())
    
    user_db = User(id=str(uuid.uuid4()), email= user.email, name = user.name, password = hashed_password)
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post('/login')
def login_user(user:UserLogin,db=Depends(get_db)):
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(400,'User with this email does not exists.')
    
    isMatch = bcrypt.checkpw(user.password.encode(),user_db.password)

    if not isMatch:
        raise HTTPException(400,'Incorrect Password')
    
    token = jwt.encode({'id':user_db.id},'password_key')
    
    return {'token':token,'user':user_db}