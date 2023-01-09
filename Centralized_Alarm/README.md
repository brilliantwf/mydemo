## 集中告警 通过EventBridge和SNS

Cloudformation 推荐部署在US-EAST-1 Region.

### 支持以下行为通知

1. 账号控制台登录
2. EC2 状态变更,停止,终止
3. IAM状态变更,"CreateUser", "CreateRole", "CreatePolicy", "CreatePolicyVersion", "AddUserToGroup", "AttachGroupPolicy", "AttachRolePolicy", "AttachUserPolicy", "PutGroupPolicy", "PutRolePolicy", "PutUserPolicy"
4. Guardduty 告警,级别>4 以上告警

### SNS 通知做了转换更加容易读

### 注意:
1. IAM 状态监控需要部署在UE1 Region


多账号需要配合Branch Stacksets:Branch_EB 参考installguide

