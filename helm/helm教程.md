# helm

## 介绍

helm 是 k8s 里面的包管理系统，用了这个，很多需要的东西直接 helm install xxxx 就完了，非常的方便

Helm 有两个重要的概念：chart 和 release。
chart 是创建一个应用的信息集合，包括各种 Kubernetes 对象的配置模板、参数定义、依赖关系、文档说明等。chart 是应用部署的自包含逻辑单元。可以将 chart 想象成 apt、yum 中的软件安装包。
release 是 chart 的运行实例，代表了一个正在运行的应用。当 chart 被安装到 Kubernetes 集群，就生成一个 release。chart 能够多次安装到同一个集群，每次安装都是一个 release。
Helm 是包管理工具，这里的包就是指的 chart。

## 下载地址

[这里](https://github.com/helm/helm/releases)下载, 手动添加到 profile

## 具体用法

### 添加 repo

```bash
helm repo add stable https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
helm repo add google https://kubernetes-charts.storage.googleapis.com
helm repo add jetstack https://charts.jetstack.io
helm repo add gitlab https://charts.gitlab.io
helm repo add goharbor https://helm.goharbor.io
helm repo add elastic https://helm.elastic.co
```
