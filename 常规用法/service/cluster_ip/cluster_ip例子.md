# cluster_ip 例子

## 说明

自动分配给集群内部用的 ip, 如果对外暴露，需要通过 nodeport 或者 ingress

## 步骤

### 启动这个 service

```bash
kubectl create -f ./http_deploy.yaml
kubectl create -f ./clusterip_service
```

### 查看

```sh
kubectl get service
```
