# cluster_ip 例子

对外暴露服务参考 ingress

## 步骤

### 启动这个 service

```bash
kubectl create -f ./http-deploy.yaml
kubectl create -f ./clusterip-service
```

### 查看

```sh
kubectl get service
```
