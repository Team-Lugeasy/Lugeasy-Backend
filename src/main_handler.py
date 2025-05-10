from fastapi import FastAPI, APIRouter, Query
from mangum import Mangum
import json

app = FastAPI(
    title="FastAPI Serverless",
    description="FastAPI를 활용한 서버리스",
    version="0.1.0",
    root_path="/v1",
)

api_router = APIRouter(prefix="/api")

@app.get("/")
async def health_check():
    response = {
        "status_code": 200,
        "data": { "message": "hihi" }
    }

    return {
        'statusCode': response["status_code"],
        'body': json.dumps(response["data"])
    }

@app.get("/login")
async def google_login(token: str):
    response = google_login(token)

    return {
        'statusCode': response["status_code"],
        'body': json.dumps(response["data"])
    }

app.include_router(api_router)

main_handler = Mangum(app)