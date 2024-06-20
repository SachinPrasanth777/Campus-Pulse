from pydantic import BaseModel


class LoginSchema(BaseModel):
    username: str
    password: str


class CreateUserSchema(BaseModel):
    username: str
    password: str


class ClubDetailsSchema(BaseModel):
    club_name: str
    club_info: str
    club_projectTitle: str
    club_projectInfo: str
    club_social_media: str