# configmap 例子

## 测试

```bash
kubectl create -f ./configmap_demo.yaml
kubectl create -f ./configmap_pod_demo.yaml
```

## 调试

```bash
kubectl get pod
kubectl exec configmap-pod-demo -it -- sh
env 查看变量
```
