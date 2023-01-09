## 1. 创建中心Eventbridge

1. 编辑默认时间总线访问权限
![[Pasted image 20230108194450.png]]
2. 在基于资源的策略中贴入如下策略,并保存
```
  {
    "Version": "2012-10-17",
    "Statement": [
      {
    
        "Sid": "allow_account_to_put_events",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": "events:PutEvents",
        "Resource": "arn:aws:events:us-east-1:12位账号:event-bus/default"
      }]
  }
```

3. 部署中心Eventbridge 规则
点击下面的链接在中心账号部署Eventbridge 规则(部署到美东1区)
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=centraeb&Region=us-east-1&templateURL=https://wh-tempdata.s3.amazonaws.com/eventbridge/centra_EB.yaml
在参数Amazon SNS parameters 中输入需要告警通知的邮箱地址.
![[Pasted image 20230109183520.png]]
创建完毕后记录下中心Eventbridge的ARN,后面会用到
![[Pasted image 20230109184100.png]]

## 2. 创建分支Eventbridge

点击如下链接在分支账号部署Eventbridge 规则(部署到美东1区),由于IAM和登录的状态变更检查需要在美东一区,因此需要在美东一区部署
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=brancheb&Region=us-east-1&templateURL=https://wh-tempdata.s3.amazonaws.com/eventbridge/Branch_EB.yaml

如果在其他区域使用资源,例如需要再新加坡区域部署则将上述链接中的Region修改为对应区域即可(或者直接切换区域)
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=brancheb&Region=ap-southeast-1&templateURL=https://wh-tempdata.s3.amazonaws.com/eventbridge/Branch_EB.yaml

在Amazon Eventbridge parameters参数中输入中心Eventbridge的ARN
![[Pasted image 20230109184210.png]]

勾选**我确认,...** 后点击创建堆栈

## 3. 验证
部署完中心和分支Eventbridge后,如果中心或者分支账号已部署上述堆栈的区域出现了以下事件,会触发邮件告警,包括:
1. 账号控制台登录
![[Pasted image 20230109184856.png]]
3. IAM 出现了异常行为包括("CreateUser", "CreateRole", "CreatePolicy", "CreatePolicyVersion", "AddUserToGroup", "AttachGroupPolicy", "AttachRolePolicy", "AttachUserPolicy", "PutGroupPolicy", "PutRolePolicy", "PutUserPolicy")
![[Pasted image 20230109184754.png]]
5. EC2 的状态出现了变更(停止,终止)
![[Pasted image 20230109184708.png]]
7. Guardduty出现4级以上的异常告警(severity>4).
![[Pasted image 20230109184829.png]]

