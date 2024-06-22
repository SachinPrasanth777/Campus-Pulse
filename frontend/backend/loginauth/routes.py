from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import JSONResponse
from loginauth.dependencies import get_current_user

protected_router = APIRouter()

@protected_router.get("/protected")
async def protected_route(current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        return JSONResponse(content={"message": "This is a protected route"})
    else:
        raise HTTPException(status_code=403, content={"message": "User not verified"})


@protected_router.get("/another-protected")
async def another_protected_route(current_user: dict = Depends(get_current_user)):
    if current_user.get('email_verified'):
        return JSONResponse(content={"message": "This is another protected route"})
    else:
        raise HTTPException(status_code=403,content={"message":"User not verified"})