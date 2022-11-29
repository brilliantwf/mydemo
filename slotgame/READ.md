老虎机游戏演示 base on lambda
参考https://docs.aws.amazon.com/zh_cn/sdk-for-javascript/v2/developer-guide/using-lambda-functions.html

1. cloudformation运行yaml文件创建基本环境(已经可以运行,只是没有调用ddb)
2. 如果需要运行ddb
- 配置config.json 有必要权限,包括DDB的admin权限
- node ddb-table-create.js 创建ddb表
- node ddb-table-populate.js 填充DDB数据集
- 替换环境中lambda 代码为slotpull.json(记得给lambda 写DDB的权限)

