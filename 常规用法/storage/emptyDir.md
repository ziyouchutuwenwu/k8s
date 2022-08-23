# emptyDir

临时空间，例如用于某些应用程序运行时所需的临时目录，且无须永久保留
一个容器需要从另一个容器中获取数据的目录(多容器共享目录)

## 例子

nginx 往 emptyDir 里面写数据
busybox 从里面读取数据并输出

### 代码

empty_dir_demo.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
name: demo
namespace: dev
spec:
containers:
  - name: nginx
    image: nginx
    ports:
      - containerPort: 80
        volumeMounts:
      - name: logs-volume
        mountPath: /var/log/nginx
  - name: busybox
    image: busybox:1.28.4
    command: ["/bin/sh", "-c", "tail -f /logs/access.log"]
    volumeMounts:
      - name: logs-volume
        mountPath: /logs
        volumes:
  - name: logs-volume
    emptyDir: {}
```

### 测试

```sh
kubectl create ns dev
kubectl creat -f ./empty_dir_demo.yaml
kubectl get pod demo -n dev -o wide
kubectl logs -f demo -c busybox -n dev
```
