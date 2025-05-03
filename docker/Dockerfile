# AWS Lambda용 Python 3.11 베이스 이미지
FROM public.ecr.aws/lambda/python:3.10

# 작업 디렉토리 설정
WORKDIR ${LAMBDA_TASK_ROOT}

# 전체 소스 복사
COPY src/ .

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Lambda 핸들러 지정
CMD ["main_handler.main_handler"]