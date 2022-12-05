# Stepfunction 实现Saga模式
参考:https://theburningmonk.com/2017/07/applying-the-saga-pattern-with-aws-lambda-and-step-functions/

环境:node v16.18.0,npm 8.19.2

1. 本地需要部署serverless 框架库,npm install serverless -g
2. 由于nodejs16版本后需要内置库,需要通过layer打包进去,需要的库已经打包好
执行

```sh
aws lambda publish-layer-version --layer-name saga --zip-file fileb://layer.zip --compatible-runtimes nodejs16.x --region ap-northeast-1
```
上传即可
3. 执行 serverless deploy 部署相关Lambda,可以修改serverless.yaml修改具体配置
4. 修改asl相关Lambda配置
5. 测试

使用如下payload测试
```json
{
  "trip_id": "5c12d94a-ee6a-40d9-889b-1d49142248b7",
  "depart": "London",
  "depart_at": "2017-07-10T06:00:00.000Z",
  "arrive": "Dublin",
  "arrive_at": "2017-07-12T08:00:00.000Z",
  "hotel": "holiday inn",
  "check_in": "2017-07-10T12:00:00.000Z",
  "check_out": "2017-07-12T14:00:00.000Z",
  "rental": "Volvo",
  "rental_from": "2017-07-10T00:00:00.000Z",
  "rental_to": "2017-07-12T00:00:00.000Z"
}
```

