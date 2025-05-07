import json
from google.oauth2 import id_token
from google.auth.transport import requests as grequests


def google_login(token: str):
    CLIENT_ID = "378524376717-j7hgi9kah8uuja1o5lroj0ffo9og3l9j.apps.googleusercontent.com"
    
    if token is None:
        return {
            "status_code": 401,
            "data": { "error_message": "No token" }
        }
    
    try:
        user_info = id_token.verify_oauth2_token(token, grequests.Request(), CLIENT_ID)

        print(user_info)

        user_id = user_info["sub"] 
        email = user_info["email"]
        name = user_info["name"]
        user_image = user_info["picture"]

        # db에 있는 유저인지 확인

        # user_id(단방향 암호화를?)로 토큰 만들기

        return {
            "status_code": 200,
            "data": { "user": {
                    "id": user_id,
                    "email": email,
                    "name": name,
                    "user_image": user_image
                }
            }
        }

    except ValueError as e:
        return {
            "status_code": 401,
            "data": { "error_message": str(e) }
        }

