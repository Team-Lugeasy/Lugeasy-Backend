from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from service.auth import AuthService
from pydantic import BaseModel


auth_router = APIRouter(prefix="/auth")

class LoginRequest(BaseModel):
    token: str

@auth_router.post("/login")
async def login(request: LoginRequest, auth_service: AuthService = Depends(AuthService)):
    response = auth_service.google_login(request.token)

    return JSONResponse(status_code=response["status_code"], content=response["data"])