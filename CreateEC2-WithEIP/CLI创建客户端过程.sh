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