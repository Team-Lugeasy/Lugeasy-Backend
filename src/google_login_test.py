import json
from google.oauth2 import id_token
from google.auth.transport import requests as grequests

CLIENT_ID = "542604644530-o5skeafu7uu64uerchsihakmqrlbn1nq.apps.googleusercontent.com"

token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjIzZjdhMzU4Mzc5NmY5NzEyOWU1NDE4ZjliMjEzNmZjYzBhOTY0NjIiLCJ0eXAiOiJKV1QifQ=.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI1NDI2MDQ2NDQ1MzAtcTFvMjhiZmIxaXJkaXBjZTY0N3Zkbm00aWlqaHI1bWouYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI1NDI2MDQ2NDQ1MzAtbzVza2VhZnU3dXU2NHVlcmNoc2loYWttcXJsYm4xbnEuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTgxODgzNTI3OTExNjcxNzc3NTYiLCJlbWFpbCI6InBsYXNoZG9mQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoi67CV7KeE7ISxIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0xHS2tXNm9WaHNvdGRrSU9rS050X19CdDAxaUVUM1M0bDRMM3V3QTlNZzlWdEVMUT1zOTYtYyIsImdpdmVuX25hbWUiOiLsp4TshLEiLCJmYW1pbHlfbmFtZSI6IuuwlSIsImlhdCI6MTc0NTQxNDUxMSwiZXhwIjoxNzQ1NDE4MTExfQ.NxzlvXiz29z8fkcTJBVnVkqXEBYWVnHA-B1cAaVa85dPYoEh1fKcf44RhFVVeJFvT3yswSYrhOw1Jq9is_eo8tuUJtFlS5qC9Q7t3djBsi7_RPsVMqC9VCIlLb5qQJnxFFi_CwcJ0_xuQJaeM1R1EqGVQ5dNXOrbgZ6h4Rr2-DUzRam15Ui5nDVM1xxh109R4_ogZx1nahyL2gff9qO9dhYVCxWc0FFjwzNsuO-kU3KS6QDfhd_CTQ9PmVuNU_WAMmY9L1ODWE9IL53zu==="




def lambda_handler(event, context):
    try:
        body = json.loads(event["body"])
        token = body["idToken"]

        # 구글 서버로부터 ID Token 검증
        idinfo = id_token.verify_oauth2_token(token, grequests.Request(), CLIENT_ID)

        userid = idinfo["sub"]  # 구글 고유 사용자 ID
        email = idinfo["email"]
        name = idinfo.get("name")

        # TODO: DB 조회 또는 JWT 발급

        return {
            "statusCode": 200,
            "body": json.dumps({
                "message": "Authentication successful",
                "user": {
                    "id": userid,
                    "email": email,
                    "name": name
                }
            }),
        }

    except ValueError:
        return {
            "statusCode": 401,
            "body": json.dumps({"message": "Invalid token"})
        }

# 🔽 로컬에서 테스트할 수 있는 main 함수
if __name__ == "__main__":




    print("token 길이:", len(token))
    print("dot 개수:", token.count("."))  # 반드시 2개여야 함

    # ------------- log -------------
    try:
        info = id_token.verify_oauth2_token(token, grequests.Request(), CLIENT_ID)
        print("✅ 인증 성공:", info)
    except ValueError as e:
        print("❌ 인증 실패:", str(e))
    # ------------- log -------------

    fake_event = {
        "body": json.dumps({
            "idToken": token
        })
    }

    response = lambda_handler(fake_event, context=None)
    print("응답 코드:", response["statusCode"])
    print("응답 본문:", json.loads(response["body"]))