# headless_service 例子

## 说明

- 该服务不会分配 cluster ip，也不通过 kube-proxy 做反向代理和负载均衡。

- 而是通过 dns 提供稳定的网络 id 来访问，dns 会将 headless service 的后端 (endpoints) 直接解析为 pod id 列表

- 主要供 statefulset 使用

## 测试

### deployment 测试

```bash
kubectl create -f ./nginx_deploy.yaml
kubectl create -f ./headless_svc.yaml
```

查看 service 对应的 endpoints

```sh
kubectl describe service ddd
```

看下 deployments 对应的 ip

```sh
kubectl get pod -o wide
```

登入 pod,查看 dns 记录

```bash
kubectl exec -it busybox -- /bin/sh
nslookup ddd
```

可以看到三个 ip

### statefulset 测试

```bash
kubectl create -f ./nginx_sts.yaml
kubectl create -f ./headless_svc.yaml
```

查看 service 对应的 endpoints

```sh
kubectl describe service ddd
```

看下 statefulset 对应的 ip

```sh
kubectl get pod -o wide
```

登入 pod, 查看 dns 记录

```bash
kubectl exec -it busybox -- /bin/sh
nslookup ddd
```

可以看到两个 ip

### 模拟失败

```bash
kubectl delete sts nginx-sts --cascade=false
kubectl delete pod nginx-sts-0
```
