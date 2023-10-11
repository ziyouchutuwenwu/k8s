# external_name 例子

## 说明

external name 类型的 Service，其实是在 kube-dns 里为你添加了一条 cname 记录

## 步骤

### 启动这个 service

```bash
kubectl create -f ./external_name.yaml
kubectl get service
```

可以看到 type 为 ExternalName

## 启动一个 busybox 的 pod

```bash
kubectl create -f busybox.yaml
kubectl exec busybox -it -- sh
ping my-service 即可看到结果
```
