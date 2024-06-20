import pymongo

import threading
lock = threading.Lock()

from dotenv import load_dotenv
import os

load_dotenv()
MongoURI = 'mongodb+srv://modysamay:samaymody@cluster0.tqzrwsb.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'
client = pymongo.MongoClient(MongoURI)
db = client["ByteBrigade"]
collection = db["club_details"]

def create(data):
    with lock:
        response = collection.insert_one(data.dict())
        return response.inserted_id