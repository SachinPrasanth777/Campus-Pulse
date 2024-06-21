from adminpage.utilities.database import Database
from authlib.integrations.starlette_client import OAuth, OAuthError
from fastapi import APIRouter, Request, HTTPException, Depends
from fastapi.responses import JSONResponse, RedirectResponse
from loginauth.dependencies import get_current_user
from adminpage.utilities.schema import LoginSchema, CreateUserSchema, ClubDetailsSchema, EventDetailsSchema , UserFeedbackSchema
from starlette.status import HTTP_401_UNAUTHORIZED

auth_router = APIRouter()
db=Database()

oauth = OAuth()
oauth.register(
    name="google",
    server_metadata_url="https://accounts.google.com/.well-known/openid-configuration",
    client_id="699902429350-29ae57boo85q1pce3lvvc4siqj7o0qqs.apps.googleusercontent.com",
    client_secret="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",
    client_kwargs={"scope": "openid profile email"},
)

@auth_router.get("/login")
async def login(request: Request):
    uri = request.url_for("auth")
    return await oauth.google.authorize_redirect(request, uri)

@auth_router.get("/auth")
async def auth(request: Request):
    try:
        token = await oauth.google.authorize_access_token(request)
    except OAuthError as e:
        return JSONResponse(content={"error": e.error})
    user = token.get("userinfo")
    if user:
        email = user.get("email", "")
        if not email.endswith("srmist.edu.in"):
            raise HTTPException(status_code=HTTP_401_UNAUTHORIZED, detail="Authentication failed: Only srmist.edu.in emails allowed", headers={"WWW-Authenticate": "Bearer"})
        request.session["user"] = dict(user)
        return RedirectResponse(url="/")
    raise HTTPException(status_code=HTTP_401_UNAUTHORIZED, detail="Authentication failed")

@auth_router.get("/clubinfo")
async def get_details(current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        response = db.club_details.find({})
        data = []
        for i in response:
            i["_id"] = str(i["_id"])
            data.append(i)
        return data
    else:
        raise HTTPException(status_code=403, content={"message": "User not verified"})

@auth_router.get("/clubinfo/{club_name}")
async def get_one_details(club_name: str,current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        response = db.club_details.find_one({"club_name": club_name})
        if not response:
            return JSONResponse({"error": "Event not found"}, status_code=404)
        response["_id"] = str(response["_id"])
        return response
    else:
        raise HTTPException(status_code=403, content={"message": "User not verified"})

@auth_router.get("/events")
async def get_events(current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        response = db.events.find({})
        data = []
        for i in response:
            i["_id"] = str(i["_id"])
            data.append(i)
        return data
    else:
        raise HTTPException(status_code=403, content={"message": "User not verified"})

@auth_router.get("/events/{title}")
async def get_event_by_slug(title: str,current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        response = db.events.find_one({"title": title})
        if not response:
            return JSONResponse({"error": "Event not found"}, status_code=404)
        response["_id"] = str(response["_id"])
        return response
    else:
        raise HTTPException(status_code=403, content={"message": "User not verified"})

@auth_router.post("/feedback")
async def feedback(data: UserFeedbackSchema):
    response = db.feedbacks.insert_one(dict(data))
    return JSONResponse({"message": "Feedback stored", "_id": str(response.inserted_id)})

@auth_router.get("/logout")
async def logout(request: Request, current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        request.session.pop("user", None)
        return RedirectResponse(url="/")
    else:
        raise HTTPException(status_code=403,content="User not Verified")