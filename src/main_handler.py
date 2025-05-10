from fastapi import FastAPI, APIRouter
from fastapi.responses import JSONResponse
from mangum import Mangum
from controller.auth import auth_router

app = FastAPI()

api_router = APIRouter(prefix="/api")
api_router.include_router(auth_router)

@api_router.get("/")
async def health_check():
    response = {
        "status_code": 200,
        "data": { "message": "hihi" }
    }

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