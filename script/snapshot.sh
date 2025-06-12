#!/bin/bash
find /etcd-backup/ -type f -name "*.db" -mtime +10 -exec rm -f {} \;
mkdir -p /etcd-backup
ETCDCTL_API=3
ETCD_ENDPOINTS="https://192.168.168.11:2379"
ETCD_CERT="/etc/etcd/kubernetes.pem"
ETCD_KEY="/etc/etcd/kubernetes-key.pem"
ETCD_CA="/etc/etcd/ca.pem"
BACKUP_DIR="/etcd-backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
HOSTNAME=$(hostname -f)
BACKUP_FILE="$BACKUP_DIR/etcd_$TIMESTAMP-backup-$HOSTNAME.db"

etcdctl --endpoints=$ETCD_ENDPOINTS \
  --cacert=$ETCD_CA \
  --cert=$ETCD_CERT \
  --key=$ETCD_KEY \
  snapshot save "$BACKUP_FILE"
