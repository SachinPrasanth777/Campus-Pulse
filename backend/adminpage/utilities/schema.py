from pydantic import BaseModel


class LoginSchema(BaseModel):
    username: str
    password: str


class CreateUserSchema(BaseModel):
    username: str
    password: str