from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from service.auth import AuthService

auth_router = APIRouter(prefix="/api/auth")

@auth_router.get("/login")
async def login(token: str, auth_service: AuthService):
    response = auth_service.google_login(token)

    return JSONResponse(status_code=response["status_code"], content=response["data"])