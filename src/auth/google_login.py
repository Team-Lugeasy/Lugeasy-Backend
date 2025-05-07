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

        print(user_info)
        print(json.dumps(user_info))

        user_id = user_info["sub"] 
        email = user_info["email"]
        name = user_info["name"]

        return {
            "status_code": 200,
            "data": { "user": {
                    "id": 'a',
                    "email": 'a',
                    "name": 'a'
                }
            }
        }

    except ValueError as e:
        return {
            "status_code": 401,
            "data": { "error_message": str(e) }
        }

