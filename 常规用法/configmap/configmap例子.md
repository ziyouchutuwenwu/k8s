# configmap 例子

## 测试

```bash
kubectl create -f ./configmap-test-pod.yaml
kubectl delete -f ./configmap-test-pod.yaml
```

## 调试

```bash
kubectl get pod
kubectl exec configmap-test-pod -it -- sh
env 查看变量
```
