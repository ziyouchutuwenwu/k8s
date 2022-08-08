# debian 安装 k8s

## 安装

```sh
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg
echo deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
apt update; apt install kubelet kubeadm kubectl -y
```

标记禁止升级

```sh
apt-mark hold kubelet kubeadm kubectl
```

## 注意

安装 docker 或者 containerd 之后，默认在禁用了 cri，需要注释掉，否则会报错

```sh
sudo vim /etc/containerd/config.toml
```

注释掉

```sh
disabled_plugins = ["cri"]
```

```sh
sudo systemctl restart containerd
```
