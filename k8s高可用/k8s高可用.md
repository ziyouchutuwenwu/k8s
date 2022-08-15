# k8s 高可用

多主配置，至少需要三台

```sh
master1 初始化，master2 和 3 通过命令同步 master1 上的数据
如果 master1 挂了，master2 需要利用 master3 来做 api 通信
```

## 步骤

### master 节点

```sh
k8s1 192.168.56.11
k8s2 192.168.56.22
k8s2 192.168.56.33
```

### 配置 lvs

- dr 模式不支持，用 nat 模式

- 或者是三台 master 上都装 lvs, 并且都不配置 virtual_server 字段

```sh
apt install -y keepalived
```

```sh
vim /etc/keepalived/keepalived.conf
```

```conf
global_defs {
    router_id lvs1
}
vrrp_instance vrrp1 {
    # 两台主机都设为 backup 非抢占模式
    state BACKUP
    # vrrp实例绑定的接口，用于发送VRRP包，根据自己的机器改
    interface enp0s8
    virtual_router_id 51
    priority 150
    nopreempt
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 123456
    }
    virtual_ipaddress {
        192.168.56.99 dev enp0s8 label enp0s8:0
    }
}
```

### 配置 haproxy

haproxy 不是必需的

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
kubeadm init --apiserver-advertise-address 192.168.56.11 --control-plane-endpoint 192.168.56.99 --token-ttl 0 --image-repository registry.aliyuncs.com/google_containers --service-cidr 10.96.0.0/16 --pod-network-cidr 10.244.0.0/16 --ignore-preflight-errors all --kubernetes-version v1.24.3 --cri-socket unix:///var/run/cri-dockerd.sock
```

#### 同步证书

见 `cert_sync.py`

### 其他 master 节点

```sh
kubeadm join 192.168.56.99:6443 --token wf5kse.etcohviss324zrse --discovery-token-ca-cert-hash sha256:dcd5c4462b4828255c67e8fe7308e1d5e11cfac7876a97f3d67950c46613fdff --control-plane --cri-socket unix:///var/run/cri-dockerd.sock
```

### 重置

```sh
kubeadm reset --cri-socket unix:///var/run/cri-dockerd.sock
```
