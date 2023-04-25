# 为NACL 增加域名防护
1. 创建lambda函数并增加network acl响应权限,参考json
2. 配置环境变量,域名和ACL名称
3. 将lambda和Cloudwatch event结合定时出发更新域名对应IP.