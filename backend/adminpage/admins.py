from fastapi import APIRouter
from adminpage import admindb
from adminpage.model import ClubDetails

admin_router = APIRouter()

@admin_router.post("/adminpage")
def upload_details(data: ClubDetails):
    id = admindb.create(data)
    return {"message": "Club detail stored", "id": str(id)}

