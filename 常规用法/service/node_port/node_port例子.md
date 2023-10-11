# node_port 例子

## 说明

对外暴露的端口，需要通过 master 访问

### 流向

从 port 和 nodePort 两个端口到来的数据都需要经过反向代理 kube-proxy，流入后端 pod 的 targetPort 上，最后到达 pod 内容器的 containerPort

### service 的 port 说明

| 名字       | 说明                                         |
| ---------- | -------------------------------------------- |
| nodePort   | 暴露给 k8s 集群外部访问                      |
| port       | 给 k8s 集群内部服务访问                      |
| targetport | pod 内端口，对应 deploy 里面的 containerPort |

### deployment 的 port 说明

| 名字          | 说明                           |
| ------------- | ------------------------------ |
| containerPort | 对应 service 里面的 targetPort |

## 例子

### 创建

```bash
kubectl apply -f ./http_deploy.yaml
kubectl apply -f ./nodeport_service.yaml
```

### 测试

pod 内测试

```bash
kubectl exec busybox -it -- sh
nc -vz service_name port
nc -vz ip port
```

pod 外测试

```bash
http://$K8S_MASTER:32580/
http://$K8S_MASTER:32581/
```
