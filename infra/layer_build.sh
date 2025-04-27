#!/bin/bash

set -e

LAYER_DIR="python/lib/python3.10/site-packages"

# 클린업
rm -rf python layer.zip

# 디렉토리 생성
mkdir -p $LAYER_DIR

# 패키지 설치
pip install -r ../requirements.txt -t $LAYER_DIR

# 압축
zip -r layer.zip python > /dev/null