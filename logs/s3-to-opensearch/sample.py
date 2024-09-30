import boto3
import re
import requests
import gzip
from requests_aws4auth import AWS4Auth

# AWS 및 OpenSearch 설정
region = 'ap-northeast-2'
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

host = 'https://search-your-domain.ap-northeast-2.es.amazonaws.com'  # OpenSearch 도메인
index = 'lambda-s3-index'
datatype = '_doc'
url = f"{host}/{index}/{datatype}"

headers = {"Content-Type": "application/json"}
s3 = boto3.client('s3')

# 정규 표현식
ip_pattern = re.compile(r'(\d+\.\d+\.\d+\.\d+)')
time_pattern = re.compile(r'\[(\d+\/\w+\/\d{4}:\d{2}:\d{2}:\d{2}\s-\d{4})\]')
message_pattern = re.compile(r'"(.+)"')

def handler(event, context):
    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        obj = s3.get_object(Bucket=bucket, Key=key)
        with gzip.GzipFile(fileobj=obj['Body']) as gzipfile:
            lines = gzipfile.readlines()
            
        for line in lines:
            line = line.decode("utf-8")
            
            # 패턴 검사
            ip_match = ip_pattern.search(line)
            time_match = time_pattern.search(line)
            message_match = message_pattern.search(line)
            
            if ip_match and time_match and message_match:
                document = {
                    "ip": ip_match.group(1),
                    "timestamp": time_match.group(1),
                    "message": message_match.group(1)
                }
                r = requests.post(url, auth=awsauth, json=document, headers=headers)
            else:
                # 여기서 로그 처리를 개선할 수 있습니다.
                print(f"Pattern not found in line: {line}")
