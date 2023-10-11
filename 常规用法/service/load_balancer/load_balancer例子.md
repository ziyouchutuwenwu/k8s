# load_balancer 例子

## 说明

对外暴露服务，不同于 nodeport 的是，这个生成的 EXTERNAL-IP 是虚拟的，类似于物理机上 lvs 创建的 VIP

## 例子

[参考地址](https://todoit.tech/k8s/metallb/)

### metallb

#### 修改 k8s 配置

```sh
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system
```

检查一下

```yaml
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system
```

#### 安装

本地集群使用 [metallb](https://metallb.universe.tf/installation/)

```sh
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.13.11/config/manifests/metallb-native.yaml
```

#### 创建配置

```yaml
# ip_addr.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
    - 192.168.32.1-192.168.32.55
```

```sh
kubectl apply -f config.yaml
```

#### 等待

等待 metallb 配置成功

```sh
kubectl wait --for=condition=Ready pods --all -n metallb-system
```

### 创建 service

```yaml
# lb_service.yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app
  annotations:
    metallb.universe.tf/address-pool: my-ip-space
spec:
  selector:
    app: my-app
  ports:
  - name: http
    port: 80
    targetPort: 8080
  type: LoadBalancer
```

```yaml
# whoami.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: whoami
  labels:
    app: containous
    name: whoami
spec:
  replicas: 2
  selector:
    matchLabels:
      app: containous
      task: whoami
  template:
    metadata:
      labels:
        app: containous
        task: whoami
    spec:
      containers:
        - name: containouswhoami
          image: containous/whoami
          resources:
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: whoami
spec:
  ports:
    - name: http
      port: 80
  selector:
    app: containous
    task: whoami
  type: LoadBalancer
```

```sh
kubectl apply -f whoami.yaml
```

### 测试

```bash
curl 192.168.32.1
```
