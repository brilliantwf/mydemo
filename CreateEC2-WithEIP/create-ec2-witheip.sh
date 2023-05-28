#!/bin/bash

# 设置变量
NUM_INSTANCES=2
REGION="us-west-2"

# 循环创建实例并分配弹性 IP
for ((i=1; i<=NUM_INSTANCES; i++)); do
    # 创建 EC2 实例并获取实例 ID
    INSTANCE_ID=$(aws ec2 run-instances --cli-input-json file://myinstance.json --region $REGION --query 'Instances[0].InstanceId' --output text)

    # 分配弹性 IP 并获取 IP 地址
    EIP_ADDRESS=$(aws ec2 allocate-address --region $REGION --query 'PublicIp' --output text)

    # 将弹性 IP 关联到实例
    aws ec2 associate-address --instance-id $INSTANCE_ID --public-ip $EIP_ADDRESS --region $REGION > /dev/null

    # 输出实例和弹性 IP 信息
    echo "EC2 实例 $i ID: $INSTANCE_ID"
    echo "弹性 IP 地址 $i: $EIP_ADDRESS"
    echo "---"
done
