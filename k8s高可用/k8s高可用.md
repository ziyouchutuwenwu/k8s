# k8s 高可用

双主配置

## 步骤

### master 节点

```sh
k8s1 192.168.56.11
k8s2 192.168.56.22
```

### 配置 lvs

参考 dr 模式配置 lvs 的文档配置

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

### 安装

安装好，pull 好 image

### 第一个 master 节点

#### 初始化

192.168.56.99 为 vip

```sh
kubeadm init --apiserver-advertise-address 192.168.56.99 --control-plane-endpoint 192.168.56.99 --token-ttl 0 --image-repository registry.aliyuncs.com/google_containers --service-cidr 10.96.0.0/16 --pod-network-cidr 10.244.0.0/16 --ignore-preflight-errors all --kubernetes-version v1.24.3 --cri-socket unix:///var/run/cri-dockerd.sock
```

#### 同步证书

见 `cert_sync.py`

### 其他 master 节点

```sh
kubeadm join 192.168.56.99:6443 --token wf5kse.etcohviss324zrse --discovery-token-ca-cert-hash sha256:dcd5c4462b4828255c67e8fe7308e1d5e11cfac7876a97f3d67950c46613fdff --cri-socket unix:///var/run/cri-dockerd.sock --control-plane
```

### 重置

```sh
kubeadm reset --cri-socket unix:///var/run/cri-dockerd.sock
```
