# token 部分

## 忘记 token 怎么加入 k8s 集群

### 列出 token

```sh
kubeadm token list
```

### master 生成永久有效的 token

```bash
kubeadm token create --ttl 0
```

### 生成 ca 证书 sha256 编码 hash 值

```bash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.\* //'
```

### 子节点加入

```bash
sudo kubeadm join 192.168.56.11:6443 --token onl54r.ijjcoc7w6ejc0h4x --discovery-token-ca-cert-hash sha256:hash值
```

加入以后，原来的节点不受影响
