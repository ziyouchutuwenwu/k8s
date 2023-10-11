# pod 调试

## 方法

### 用 kubectl debug

如果没有命令提示符号，按回车即可

- 不生成新 pod

比如需要调试 demo-pod 这个 pod

```sh
kubectl debug -it demo-pod --image=busybox:1.28.4 --share-processes
```

- 生成新的 pod

```sh
kubectl debug -it configmap-test-pod --image=busybox:1.28.4 --share-processes --copy-to=debug-xxx
```

### 用 debug 版 pod

busybox 可以用来调试一些网络相关的

```sh
kubectl create -f ./busybox.yaml
kubectl exec busybox -it -- sh
```

alpine 可以放 go 程序调试

```sh
kubectl create -f ./alpine.yaml
kubectl exec alpine -it -- sh
```
