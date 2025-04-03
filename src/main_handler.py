# action 작동 확인
import json
from user.get_user import get_user
from user.create_user import create_user

def main_handler(event, context): 
    request = json.dumps(event)

    # 인증 처리
        
    # 전역 분기 함수
    
    path = request.path
    httpMethod = request.httpMethod
    
    response = None
    
    if httpMethod == "GET":
        if path == "/user":
            response = get_user()
        
    elif httpMethod == "POST":
        if path == "/user":
            response = create_user()
    
    elif httpMethod == "DELETE":
        pass
    
    elif httpMethod == "PUT":
        pass
    
    # 404 Error -> 전역 error handler가 있더라
    
    # response dto도 한번에 처리
    
    return {
        'statusCode': 200,
        'body': response
    }
   