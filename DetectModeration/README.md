## 使用Lambda Rekognition 识别不适当内容

1. 按照ipynb 中的指导创建Lambda
2. 上传到指定存储桶(需要指定bucketname)后,上传任何图片会触发Rekognition 并返回Revealing Clothes,Suggestive,Confidence等指标

参考:

- 功能介绍 https://docs.aws.amazon.com/zh_cn/rekognition/latest/dg/procedure-moderate-images.html

- 产品定价 https://aws.amazon.com/cn/rekognition/pricing/ (第二组价格)