# localPV

localPV 相当于 hostPath + nodeAffinity

## 步骤

### 注册 sc

local_storage_demo.yaml

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: local-storage-demo
# 不支持 Dynamic Provisioning 动态生成 PV
provisioner: kubernetes.io/no-provisioner
# 延迟绑定，用于pv和node的绑定
volumeBindingMode: WaitForFirstConsumer
```

创建

```sh
kubectl create -f local_storage_demo.yaml
```

### 创建 pv

local_pv_demo.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv-demo
spec:
  capacity:
    storage: 5Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  # 定义好的存储类
  storageClassName: local-storage-demo
  local:
    path: /mnt/disks/vol1
  # 这里定义必须调度在这个节点上面
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - k8s2
```

查看

```sh
kubectl get pv
```

### 创建 pvc

local_pvc_demo.yaml

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: local-pvc-demo
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: local-storage-demo
```

创建

```sh
kubectl create -f local_pvc_demo.yaml
kubectl get pvc
```

### 创建 pod

localpv_pod_demo.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: localpv-pod-demo
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: local-pvc-demo-volume
  volumes:
    - name: local-pvc-demo-volume
      persistentVolumeClaim:
        claimName: local-pvc-demo
```

创建

```sh
kubectl create -f localpv_pod_demo.yaml
kubectl get pods -o wide
kubectl get pvc
kubectl get pv
```

### 验证

```sh
kubectl exec -it localpv-pod-demo -- /bin/bash
cd /usr/share/nginx/html/
touch test.html
ls
test.html
```

在宿主机上检查

```sh
ls /mnt/disks/vol1/
test.html
```
