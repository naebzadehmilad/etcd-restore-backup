root@k8sm1:/etc/etcd# cat etcd-status.sh
etcdctl --endpoints=https://192.168.168.45:2379 \
  --cert=/etc/etcd/kubernetes.pem \
  --key=/etc/etcd/kubernetes-key.pem \
  --cacert=/etc/etcd/ca.pem \
  endpoint status --cluster --write-out=table
