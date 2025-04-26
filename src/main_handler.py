from user.get_user import get_user
from user.create_user import create_user
from auth.google_login import google_login

def main_handler(event, context): 
    path = event.get("path")
    httpMethod = event.get("httpMethod")
    
    response = None
    
    if httpMethod == "GET":
        if path == "/user":
            response = get_user()
        
    elif httpMethod == "POST":
        if path == "/user":
            response = create_user()
        elif path == "/auth/google/login":
            response = google_login()
    
    elif httpMethod == "DELETE":
        pass
    
    elif httpMethod == "PUT":
        pass
    
    return {
        'statusCode': 200,
        'body': response
    }
