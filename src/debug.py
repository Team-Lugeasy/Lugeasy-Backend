from main_handler import main_handler

if __name__ == "__main__":
    fake_event = {
        "httpMethod": "GET",
        "path": "/api"
    }

    response = main_handler(event = fake_event, context=None)

    print(response)