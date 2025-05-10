class RootService:
    def health_check(self):
        return {
            "status_code": 200,
            "data": "health check"
        }