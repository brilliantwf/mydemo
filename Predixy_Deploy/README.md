## Predixy 自动部署脚本

Predixy 介绍 https://github.com/joyieldInc/predixy/blob/master/README_CN.md


单机版用Predixydeploy.yaml
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=Predixy&Region=us-east-1&templateURL=https://wh-tempdata.s3.amazonaws.com/Predixy/Predixydeploy.yaml
集群版用NLBwithPredixy.yaml
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=PredixyCluster&Region=us-east-1&templateURL=https://wh-tempdata.s3.amazonaws.com/Predixy/NLBwithPredixy.yaml


注意: 配置文件未做调优,仅供测试