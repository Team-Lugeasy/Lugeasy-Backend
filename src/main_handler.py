from fastapi import FastAPI, APIRouter
from fastapi.responses import JSONResponse
from mangum import Mangum
from controller.root import root_router
from controller.auth import auth_router

app = FastAPI()

api_router = APIRouter(prefix="/api")
api_router.include_router(auth_router)
api_router.include_router(root_router)
app.include_router(api_router)

@app.exception_handler(404)
async def not_found_handler(request, exc):
    response = {
        "status_code": 404,
        "data": { "message": f"경로 '{request.url.path}'를 찾을 수 없습니다." }
    }
    return JSONResponse(status_code=404, content=response)

main_handler = Mangum(app)