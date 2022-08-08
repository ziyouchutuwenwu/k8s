# debian 安装 k8s

## 安装

```sh
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
echo deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main > /etc/apt/sources.list.d/kubernetes.list
apt update; apt install kubelet kubeadm kubectl -y
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
