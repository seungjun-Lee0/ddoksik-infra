import boto3
import gzip
import json
from io import BytesIO
import requests  # requests 모듈을 사용하기 위해 필요

# OpenSearch 도메인 엔드포인트 설정
opensearch_endpoint = 'https://search-ddoksik-vg6hgwk3if5ofeftuystz5scea.ap-northeast-2.es.amazonaws.com'
index_name = 'alb-logs'
opensearch_url = f"{opensearch_endpoint}/{index_name}/_doc/_bulk"

# AWS credentials for requests authentication (if needed)
# AWS4Auth를 사용한 인증을 위해 필요한 경우 사용
from requests_aws4auth import AWS4Auth
region = 'ap-northeast-2'  # 예: 'us-west-2'
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key, region, service, session_token=credentials.token)

headers = {"Content-Type": "application/x-ndjson"}

def parse_alb_log(log_line):
    # fields = log_line.split(' ')
    # 공백이 하나 이상인 경우를 위한 정규 표현식 사용
    fields = re.split(r'\s+', log_line.strip())
    log_entry = {
        "type": fields[0],
        "time": fields[1],
        "elb": fields[2],
        "client_ip": fields[3].split(':')[0],
        "target_ip": fields[4].split(':')[0],
        "request_processing_time": fields[5],
        "target_processing_time": fields[6],
        "response_processing_time": fields[7],
        "elb_status_code": fields[8],
        "target_status_code": fields[9],
        "received_bytes": fields[10],
        "sent_bytes": fields[11],
        "request": fields[12],
        "user_agent": fields[13],
        "ssl_cipher": fields[14],
        "ssl_protocol": fields[15],
        "target_group_arn": fields[16],
        "trace_id": fields[17],
        "domain_name": fields[18],
        "chosen_cert_arn": fields[19],
        "matched_rule_priority": fields[20],
        "request_creation_time": fields[21],
        "actions_executed": fields[22],
        "redirect_url": fields[23]
    }
    return log_entry

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    bulk_data = ""

    for record in event['Records']:
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
        
        obj = s3.get_object(Bucket=bucket, Key=key)
        with gzip.open(BytesIO(obj['Body'].read()), 'rt') as f:
            for line in f:
                log_entry = parse_alb_log(line)
                # _bulk API 형식에 맞게 데이터 구성
                action = {"index": {"_index": index_name, "_type": "_doc"}}
                bulk_data += json.dumps(action) + '\n' + json.dumps(log_entry) + '\n'
    
    # OpenSearch에 데이터 전송
    if bulk_data:  # 데이터가 있는 경우에만 전송
        response = requests.post(opensearch_url, auth=awsauth, headers=headers, data=bulk_data)
        print(response.status_code)
        print(response.text)

    return {'statusCode': 200, 'body': json.dumps('Success')}