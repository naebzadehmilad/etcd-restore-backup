#!/bin/bash
set -e

export ETCDCTL_API=3
export ETCD_CERT="/etc/etcd/kubernetes.pem"
export ETCD_KEY="/etc/etcd/kubernetes-key.pem"
export ETCD_CA="/etc/etcd/ca.pem"

RESTORE_FILE="/etcd-backup/etcd_2025-06-12_21-28-backup-k8sm1.db"
ETCD_DATA_DIR="/var/lib/etcd"

ETCD_NAME="$1"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://$1:2380"

ETCD_INITIAL_CLUSTER="192.168.168.44=https://192.168.168.44:2380,192.168.168.45=https://192.168.168.45:2380,192.168.168.12=https://192.168.168.12:2380,192.168.168.11=https://192.168.168.11:2380,192.168.168.10=https://192.168.168.10:2380"


if [ -z "$1" ]; then
  echo "Error: you must provide the node name (e.g. ./restore.sh 192.168.168.10)"
  exit 1
fi

etcdctl snapshot restore "$RESTORE_FILE" \
  --name "$ETCD_NAME" \
  --initial-cluster "$ETCD_INITIAL_CLUSTER" \
  --initial-advertise-peer-urls "$ETCD_INITIAL_ADVERTISE_PEER_URLS" \
  --data-dir "$ETCD_DATA_DIR"

echo "Restore completed successfully."

