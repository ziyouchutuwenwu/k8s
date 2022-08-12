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

```python
import argparse
import os
import sys

def sync_cert_to_host(ip, username, password):
    cmd = 'sshpass -p %s ssh %s@%s "mkdir -p /etc/kubernetes/pki/etcd"' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/ca.crt %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/ca.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/sa.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/sa.pub %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/front-proxy-ca.crt %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/front-proxy-ca.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/etcd/ca.crt %s@%s:/etc/kubernetes/pki/etcd/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p %s scp /etc/kubernetes/pki/etcd/ca.key %s@%s:/etc/kubernetes/pki/etcd/' % (password, username, ip)
    os.system(cmd)

if __name__ == '__main__':
    script_name = str(sys.argv[0])
    if len(sys.argv) != 2:
        print("用法: %s --hosts=192.168.56.22:root:root123456,192.168.56.33:root:root123456" % script_name)
        exit(-1)

    parser = argparse.ArgumentParser()
    parser.add_argument("--hosts")
    args = parser.parse_args()
    hosts = args.hosts.split(",")
    for host in hosts:
        ip = host.split(":")[0]
        username = host.split(":")[1]
        password = host.split(":")[-1]
        sync_cert_to_host(ip, username, password)
```

### 其他 master 节点

```sh
kubeadm join 192.168.56.99:6443 --token wf5kse.etcohviss324zrse --discovery-token-ca-cert-hash sha256:dcd5c4462b4828255c67e8fe7308e1d5e11cfac7876a97f3d67950c46613fdff --cri-socket unix:///var/run/cri-dockerd.sock --control-plane
```

### 重置

```sh
kubeadm reset --cri-socket unix:///var/run/cri-dockerd.sock
```
