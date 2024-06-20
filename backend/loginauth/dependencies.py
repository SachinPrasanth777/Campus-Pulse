from fastapi import Request, HTTPException
from starlette.status import HTTP_401_UNAUTHORIZED

def get_current_user(request: Request):
    user = request.session.get("user")
    if user is None:
        raise HTTPException(status_code=HTTP_401_UNAUTHORIZED, detail="Unauthorized", headers={"WWW-Authenticate": "Bearer"})
    email = user.get("email", "")
    if not email.endswith("srmist.edu.in"):
        raise HTTPException(status_code=HTTP_401_UNAUTHORIZED, detail="Unauthorized: Only srmist.edu.in emails allowed", headers={"WWW-Authenticate": "Bearer"})
    return user
