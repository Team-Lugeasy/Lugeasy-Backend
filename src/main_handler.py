from user.get_user import get_user
from user.create_user import create_user
from auth.google_login import google_login
import json

def main_handler(event, context): 
    path = event.get("path")
    httpMethod = event.get("httpMethod")
    
    response = None
    
    if httpMethod == "GET":
        if path == "/api":
            response = {
            "status_code": 200,
            "data": { "message": "hihi" }
        }

    elif httpMethod == "POST":
        if path == "/user":
            response = create_user()
        elif path == "/api/login/google":
            body = json.loads(event.get("body", "{}"))
            token = body.get("token")
            response = google_login(token)
    
    elif httpMethod == "DELETE":
        pass
    
    elif httpMethod == "PUT":
        pass
    
    return {
        'statusCode': response["status_code"],
        'body': json.dumps(response["data"])
    }
