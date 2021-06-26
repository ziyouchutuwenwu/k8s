# kuboard

manjaro 测试发现不支持，升降内核版本都不行

## 安装 k3s

第二行用于给普通用户添加可读权限

```sh
curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
sudo chmod +r /etc/rancher/k3s/k3s.yaml
kubectl get node
```

## 安装 kubeadmin 等

```sh
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
echo deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
apt update; apt install kubelet kubeadm kubectl -y
```

## 安装 kuboard

```sh
docker run -d \
  --restart=unless-stopped \
  --name=kuboard \
  -p 7654:80/tcp \
  -p 10081:10081/tcp \
  -e KUBOARD_ENDPOINT="http://192.168.88.73:7654" \
  -e KUBOARD_AGENT_SERVER_TCP_PORT="10081" \
  swr.cn-east-2.myhuaweicloud.com/kuboard/kuboard:v3
```

KUBOARD_ENDPOINT 是 kuboar 的 web 端访问地址

默认密码

```sh
admin
Kuboard123
```
