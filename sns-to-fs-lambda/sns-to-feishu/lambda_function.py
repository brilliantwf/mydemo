import json
import requests
import os
# 处理 SNS 消息并将其发送到 feishu webhook 接口
def lambda_handler(event, context):
    # 解析 SNS 消息
    sns_message = json.loads(event['Records'][0]['Sns']['Message'])
    
    # 提取消息内容
    message = sns_message
    
    # 发送消息到 feishu webhook 接口
    # 这里需要替换为你的 feishu webhook 接口地址
    feishu_webhook_url = os.environ['Feishu_Webhook']
    
    # 构建 feishu 消息
    feishu_message = {
            "msg_type": "text", 
            "content": {
                "text": message
            }
    }
    
    # 发送消息到 feishu webhook 接口
    # 这里使用了 requests 库发送 HTTP POST 请求
    response = requests.post(feishu_webhook_url, json=feishu_message)
    
    # 检查响应状态码
    if response.status_code == 200:
        print("消息发送成功")
        return "OK"
    else:
        print("消息发送失败")
        return "Error"
    
    