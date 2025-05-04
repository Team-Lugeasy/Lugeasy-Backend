import json
from google.oauth2 import id_token
from google.auth.transport import requests as grequests


def google_login(token: str):
    CLIENT_ID = "542604644530-o5skeafu7uu64uerchsihakmqrlbn1nq.apps.googleusercontent.com"
    
    if token is None:
        return {
            "status_code": 401,
            "data": { "error_message": "No token" }
        }
    try:
        user_info = id_token.verify_oauth2_token(token, grequests.Request(), CLIENT_ID)

        user_id = user_info["sub"] 
        email = user_info["email"]
        name = user_info["name"]

        # TODO: DB 조회 또는 JWT 발급

        return {
            "status_code": 200,
            "data": { "user": {
                    "id": user_id,
                    "email": email,
                    "name": name
                }
            }
        }
    
    

    except ValueError as e:
        return {
            "status_code": 401,
            "data": { "error_message": "Invalid token" }
        }

