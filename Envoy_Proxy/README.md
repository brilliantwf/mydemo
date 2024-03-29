# Redis/Elasticache Cluster 代理(基于Envoy)

## 功能

支持:

1. 集群模式,数据分片
2. 自动读写分离,策略 prefer_relica
3. 支持流量镜像,需要改写envoy.yaml
4. 更多功能参考https://www.envoyproxy.io/docs/envoy/latest/configuration/listeners/network_filters/redis_proxy_filter

## 部署
https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/quickcreate?stackName=envoy&Region=us-east-1&templateURL=https://wh-tempdata.s3.amazonaws.com/enovy/envoydeploy.yaml

部署完毕后,使用单机版客户端 连接envoyprivateIp的 6379端口即可

例如:./redis-cli -h 10.0.1.135 -p 6379


**注意:**
仅做快速测试用,生产环境慎用!

Ref:

https://www.envoyproxy.io/docs/envoy/latest/start/start

https://icloudnative.io/envoy-handbook/docs/overview/overview/

https://cloudnative.to/blog/redis-cluster-with-istio/