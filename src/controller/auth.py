from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from service.auth import AuthService
from pydantic import BaseModel


auth_router = APIRouter(prefix="/auth")

class LoginRequest(BaseModel):
    token: str

@auth_router.post("/login")
async def login(request: LoginRequest, social: str, auth_service: AuthService = Depends(AuthService)):
    match social:
        case "google":
            response = auth_service.google_login(request.token)
        case "apple":
            response = auth_service.apple_login(request.token) 
        case _:
            return JSONResponse(status_code=400, content={"message": "지원하지 않는 소셜 로그인입니다."})

    return JSONResponse(status_code=response["status_code"], content=response["data"])