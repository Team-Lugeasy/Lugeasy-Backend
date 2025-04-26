import json
from google.oauth2 import id_token
from google.auth.transport import requests as grequests
import requests

CLIENT_ID = ""
token = ""

def google_login():
    try:
        token_info_url = 'https://www.googleapis.com/oauth2/v3/userinfo'
        params = {'access_token': token}

        response = requests.get(token_info_url, params=params)

        print(response.json())

        # response = requests.get("https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=${token}")

        # 구글 서버로부터 ID Token 검증
        # idinfo = id_token.verify_oauth2_token(token, grequests.Request(), CLIENT_ID)

        # userid = idinfo["sub"]  # 구글 고유 사용자 IDS
        # email = idinfo["email"]
        # name = idinfo.get("name")

        # TODO: DB 조회 또는 JWT 발급

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Authentication successful",
                "user": {
                    "id": 'userid',
                    "email": 'email',
                    "name": 'name'
                }
            }),
        }

    except ValueError as e:
        return {
            "statusCode": 401,
            "body": json.dumps({"message": "Invalid token"})
        }

