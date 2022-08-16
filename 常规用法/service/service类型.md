# service 类型

## 分类

### clusterip

自动分配给集群内部用的 ip

### headless service

该服务不会分配 cluster ip，也不通过 kube-proxy 做反向代理和负载均衡。而是通过 dns 提供稳定的网络 id 来访问，dns 会将 headless service 的后端 (endpoints) 直接解析为 pod id 列表，主要供 statefulset 使用

### nodeport

```sh
对外暴露的端口
```

### external name

external name 类型的 Service，其实是在 kube-dns 里为你添加了一条 cname 记录
