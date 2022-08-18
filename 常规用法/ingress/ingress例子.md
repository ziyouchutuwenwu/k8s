# ingress 例子

## 步骤

### 用法

```sh
kubectl apply -f ./ingress.yaml
```

### 查看 ip 地址

```sh
watch kubectl get ingress
```

等几分钟，到 address 里面有 ip 地址以后，/etc/hosts 里面配置这个地址
