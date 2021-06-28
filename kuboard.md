# kuboard

## 安装

非集群内安装

```sh
docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 7777:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://主机IP:7777" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  -v /root/kuboard-data:/data \
  eipwork/kuboard:v3
```

k8s 集群内安装

```sh
kubectl apply -f https://addons.kuboard.cn/kuboard/kuboard-v3.yaml
```

登陆密码

```sh
admin
Kuboard123
```

## ingress 测试
