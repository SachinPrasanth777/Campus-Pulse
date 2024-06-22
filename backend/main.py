from fastapi import FastAPI
from starlette.middleware.sessions import SessionMiddleware
from fastapi.middleware.cors import CORSMiddleware
from loginauth.auth import auth_router
from loginauth.routes import protected_router
from adminpage.utilities.database import Database
from adminpage.routes import admin
import os
from dotenv import load_dotenv

load_dotenv()
app = FastAPI()
db=Database()

SECRET_KEY = os.getenv("CLIENT_SECRET")
app.add_middleware(SessionMiddleware, secret_key=SECRET_KEY)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth_router)
app.include_router(protected_router)
app.include_router(admin.router)


@app.get('/')
async def test():
    return {"Test": "Modules Loaded Successfully"}
