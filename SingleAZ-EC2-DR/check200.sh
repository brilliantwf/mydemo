#!/bin/bash
url="http://vv-nlb-5c0b78c8460ad236.elb.us-west-2.amazonaws.com/" # 将此处的URL更改为您要检查的网站的URL
interval=3 # 每次检查之间的时间间隔（以秒为单位）

while true; do
  status_code=$(curl --write-out "%{http_code}\n" --silent --output /dev/null $url)

  if [[ $status_code -eq 200 ]]; then
    echo "$(date): Website is up and running!"
  else
    echo "$(date): Website is down or inaccessible. Status code: $status_code"
  fi

  sleep $interval # 等待指定的时间间隔
done
