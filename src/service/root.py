class RootService:
    def health_check():
        return {
            "status_code": 200,
            "data": "health check"
        }