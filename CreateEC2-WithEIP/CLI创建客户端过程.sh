## 进入AWS CLi,也可以采用 Cloudshell
## 下载policy.json
## 创建myinstance.json 并修改
注意修改里面的参数,  "MinCount": 1 "MaxCount": 1,请设置为1,实例数量在后面脚本中修改
## 创建Role
aws iam create-role --role-name myInstanceRole --assume-role-policy-document file://policy.json
## 挂载策略(示例,非必须)
aws iam attach-role-policy --role-name myInstanceRole --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
aws iam attach-role-policy --role-name myInstanceRole --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
## 创建profile
aws iam create-instance-profile --instance-profile-name myInstanceProfile
aws iam add-role-to-instance-profile --role-name myInstanceRole --instance-profile-name myInstanceProfile
## 批量创建EC2
修改create-ec2-witheip.sh  中的实例数量和区域
执行 sh ./create-ec2-witheip.sh  

成功创建后输出如下:

```
EC2 实例 1 ID: i-034fdb02520b6520a
弹性 IP 地址 1: 52.40.231.50
---
EC2 实例 2 ID: i-076ee35d6e22a77ff
弹性 IP 地址 2: 35.155.96.87
---
```