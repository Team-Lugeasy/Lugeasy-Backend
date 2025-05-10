from fastapi import FastAPI, APIRouter, Query
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