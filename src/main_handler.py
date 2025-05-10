from fastapi import FastAPI, APIRouter
from fastapi.responses import JSONResponse
from mangum import Mangum
import json

app = FastAPI()

api_router = APIRouter(prefix="/api")

@app.get("/")
async def health_check():
    response = {
        "status_code": 200,
        "data": { "message": "hihi" }
    }

    return JSONResponse(status_code=response["status_code"], content=response["data"])

@app.get("/login")
async def google_login(token: str):
    response = google_login(token)

    return JSONResponse(status_code=response["status_code"], content=response["data"])

@app.exception_handler(404)
async def not_found_handler(request, exc):
    response = {
        "status_code": 404,
        "data": { "message": f"경로 '{request.url.path}'를 찾을 수 없습니다." }
    }
    return JSONResponse(status_code=404, content=response)

app.include_router(api_router)

main_handler = Mangum(app)