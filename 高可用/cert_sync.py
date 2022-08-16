import argparse
import os
import sys


def sync_cert_to_host(ip, username, password):
    cmd = 'sshpass -p "%s" ssh %s@%s "mkdir -p /etc/kubernetes/pki/etcd"' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/ca.crt %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/ca.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/sa.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/sa.pub %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/front-proxy-ca.crt %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/front-proxy-ca.key %s@%s:/etc/kubernetes/pki/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/etcd/ca.crt %s@%s:/etc/kubernetes/pki/etcd/' % (password, username, ip)
    os.system(cmd)
    cmd = 'sshpass -p "%s" scp /etc/kubernetes/pki/etcd/ca.key %s@%s:/etc/kubernetes/pki/etcd/' % (password, username, ip)
    os.system(cmd)


if __name__ == "__main__":
    script_name = str(sys.argv[0])
    if len(sys.argv) != 2:
        print("用法: %s --hosts=192.168.56.22:root:root123456,192.168.56.33:root:" % script_name)
        exit(-1)

    parser = argparse.ArgumentParser()
    parser.add_argument("--hosts")
    args = parser.parse_args()
    hosts = args.hosts.split(",")
    for host in hosts:
        ip = host.split(":")[0]
        username = host.split(":")[1]
        password = host.split(":")[-1]
        sync_cert_to_host(ip, username, password)
