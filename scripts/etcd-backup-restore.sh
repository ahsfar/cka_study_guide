#!/bin/bash

# Backup
export ETCDCTL_API=3
export ETCDCTL_CACERT="/path/to/ca.crt"
export ETCDCTL_CERT="/path/to/etcd.crt"
export ETCDCTL_KEY="/path/to/etcd.key"
BACKUP_PATH="/path/to/snapshot.db"

echo "Starting etcd backup..."
etcdctl snapshot save $BACKUP_PATH
echo "Backup saved to $BACKUP_PATH"

# Restore
# Ensure etcd service is stopped before restore
echo "Stopping etcd service..."
sudo systemctl stop etcd

RESTORE_PATH="/path/to/new/data-dir"
echo "Starting etcd restore..."
etcdctl snapshot restore $BACKUP_PATH --data-dir $RESTORE_PATH
echo "Restore completed to $RESTORE_PATH"

# Update etcd service configuration if necessary
# This step is manual and needs to be adjusted according to your setup

# Restart etcd service
echo "Restarting etcd service..."
sudo systemctl daemon-reload
sudo systemctl start etcd
echo "etcd service restarted."

# Verify
echo "Verifying etcd cluster health..."
etcdctl member list
etcdctl endpoint health


# give the execution rights to run the scirpt => chmod +x etcd-backup-restore.sh
