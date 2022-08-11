# k8s 高可用

双主配置

## 步骤

### master 节点

```sh
k8s1 192.168.56.11
k8s2 192.168.56.22
k8s3 192.168.56.33
```

### 配置 lvs

lvs 用于生成虚拟 ip

```sh
apt install -y keepalived
```

```sh
vim /etc/keepalived/keepalived.conf
```

### 配置 haproxy

haproxy 用于 k8s 的 api-server 的高可用

```sh
apt install -y haproxy
```

```sh
vim /etc/haproxy/haproxy.cfg
```

检查

```sh
http://192.168.56.99:8081/haproxy/stats
```

### 第一个 master 节点

#### 初始化

192.168.56.99 为虚拟 ip，6444 为 haproxy 里面指定的端口

```sh
kubeadm init --apiserver-advertise-address=192.168.56.11 --control-plane-endpoint=192.168.56.99 --image-repository registry.aliyuncs.com/google_containers --service-cidr=10.96.0.0/16 --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all --kubernetes-version v1.24.3 --cri-socket unix:///var/run/cri-dockerd.sock
```

```sh
kubeadm init --apiserver-advertise-address=192.168.56.99 --apiserver-bind-port=6444 --control-plane-endpoint=192.168.56.99 --image-repository registry.aliyuncs.com/google_containers --service-cidr=10.96.0.0/16 --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=all --kubernetes-version v1.24.3 --cri-socket unix:///var/run/cri-dockerd.sock
```

#### 同步证书

```sh
#!/bin/bash

USER=root
CONTROL_PLANE_IPS="k8s2 k8s3"
for host in ${CONTROL_PLANE_IPS}; do
    ssh "${USER}"@$host "mkdir -p /etc/kubernetes/pki/etcd"
    scp /etc/kubernetes/pki/ca.crt "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/ca.key "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/sa.key "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/sa.pub "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/front-proxy-ca.crt "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/front-proxy-ca.key "${USER}"@$host:/etc/kubernetes/pki/
    scp /etc/kubernetes/pki/etcd/ca.crt "${USER}"@$host:/etc/kubernetes/pki/etcd/
    # Quote this line if you are using external etcd
    scp /etc/kubernetes/pki/etcd/ca.key "${USER}"@$host:/etc/kubernetes/pki/etcd/
done
```

### 其他 master 节点

```sh
kubeadm join 192.168.56.99:6443 --token wf5kse.etcohviss324zrse --discovery-token-ca-cert-hash sha256:dcd5c4462b4828255c67e8fe7308e1d5e11cfac7876a97f3d67950c46613fdff --cri-socket unix:///var/run/cri-dockerd.sock --control-plane
```

### 重置

```sh
kubeadm reset --cri-socket unix:///var/run/cri-dockerd.sock
```
