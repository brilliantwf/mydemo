#!/bin/bash

while getopts ":r:s:" opt; do
  case $opt in
    r) region="$OPTARG";;
    s) source_cidr="$OPTARG";;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1;;
  esac
done

if [ -z "$region" ] || [ -z "$source_cidr" ]; then
  echo "Usage: $0 -r <region> -s <source_cidr>"
  exit 1
fi

# 获取包含22或80端口规则的安全组ID
security_group_ids=$(aws ec2 describe-security-groups --region $region \
    --query 'SecurityGroups[?IpPermissions[?ToPort==`22` || ToPort==`80`]].GroupId' \
    --output text)

# 修改每个安全组的端口为80和22的规则
for sg_id in $security_group_ids; do
    # 修改端口为80的安全组规则
    if ! aws ec2 authorize-security-group-ingress \
        --region $region \
        --group-id $sg_id \
        --protocol tcp \
        --port 80 \
        --cidr $source_cidr; then
        echo "Error updating rules for $sg_id on port 80."
    fi

    # 修改端口为22的安全组规则
    if ! aws ec2 authorize-security-group-ingress \
        --region $region \
        --group-id $sg_id \
        --protocol tcp \
        --port 22 \
        --cidr $source_cidr; then
        echo "Error updating rules for $sg_id on port 22."
    fi

    echo "Security group rules updated for $sg_id."
done

echo "All security group rules updated successfully."
