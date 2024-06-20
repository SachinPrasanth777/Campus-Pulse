from typing import Annotated

from pydantic import BaseModel, AnyUrl



class ClubDetails(BaseModel):
    club_name: str
    club_info: str
    club_projectTitle: str
    club_projectInfo: str
    club_social_media: str
