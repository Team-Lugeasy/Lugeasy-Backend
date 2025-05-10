from fastapi import APIRouter, Depends
from fastapi.responses import JSONResponse
from service.root import RootService

root_router = APIRouter(prefix="")

@root_router.get("/")
async def health_check(root_service: RootService = Depends(RootService)):
    response = root_service.health_check()

    return JSONResponse(status_code=response["status_code"], content=response["data"])