from fastapi import APIRouter, Request
from adminpage.utilities.database import Database
from adminpage.utilities.schema import LoginSchema, CreateUserSchema, ClubDetailsSchema, EventDetailsSchema , UserFeedbackSchema
from adminpage.utilities.hash import hash_password, check_password
from adminpage.utilities.response import JSONResponse
from adminpage.utilities.jwt import create_token, read_token

router = APIRouter()
db = Database()


@router.post("/create-admin")
async def create_user(user: CreateUserSchema):
    if db.users.find_one({"username": user.username}):
        return JSONResponse({"error": "User already exists"}, status_code=400)
    db.users.insert_one(
        {"username": user.username, "password": hash_password(user.password).decode()}
    )
    return JSONResponse({"message": "User created"})


@router.post("/admin-login")
async def login(user: LoginSchema):
    user_data = db.users.find_one({"username": user.username})
    if not user_data:
        return JSONResponse({"error": "User does not exist"}, status_code=404)
    if not check_password(user.password, user_data["password"]):
        return JSONResponse({"error": "Invalid password"}, status_code=403)
    token = create_token(
        {
            "username": user.username,
            "password": user_data["password"],
            "id": str(user_data["_id"]),
        },
        secret=db.secret,
    )
    return JSONResponse({"token": str(token), "message": "Login validated"})

@router.post("/clubinfo")
async def upload_details(req: Request, data: ClubDetailsSchema):
    auth_header = req.headers.get("Authorization")
    if not auth_header:
        return JSONResponse({"error": "No token provided"}, status_code=403)
    token = auth_header.split(" ")[1]
    try:
        token_data = read_token(token, secret=db.secret)
    except Exception as e:
        return JSONResponse({"error": "Invalid token"}, status_code=403)
    data._id = token_data["id"]
    response = db.club_details.insert_one(dict(data))
    return JSONResponse({"message": "Club detail stored", "id": str(response.inserted_id)})

@router.post("/add-events")
async def upload_events(req:Request,value: EventDetailsSchema):
    auth_header = req.headers.get("Authorization")
    if not auth_header:
        return JSONResponse({"error": "No token provided"}, status_code=403)
    try:
        token = auth_header.split(" ")[1]
    except IndexError:
        return JSONResponse({"error": "Invalid token format"}, status_code=403)
    try:
        token_data = read_token(token, secret=db.secret)
    except Exception as e:
        return JSONResponse({"error": "Invalid token"}, status_code=403)
    value._id = token_data["id"]
    response = db.events.insert_one(dict(value))
    return JSONResponse({"message": "Events detail stored", "id": str(response.inserted_id)})