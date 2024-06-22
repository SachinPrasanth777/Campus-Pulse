from pymongo import MongoClient
from dotenv import load_dotenv

import os

load_dotenv()


class Database:
    def __init__(self):
        db_name, db_uri = os.getenv("DB_NAME"), os.getenv("DB_URI")
        self.secret = os.getenv("SECRET")
        self.client = MongoClient(db_uri)
        self.db = self.client[db_name]
        self.users = self.db.users
        self.club_details = self.db.club_details

    def __del__(self):
        self.client.close()
