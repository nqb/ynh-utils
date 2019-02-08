#!/bin/bash
set -e

REMOTE_BACKUP_DIR=/home/yunohost.backup/archives
LOCAL_BACKUP_DIR=/var/backups/ynh
NB_DAYS_TO_KEEP_FILES=7

scp vps:$REMOTE_BACKUP_DIR/`date +%Y%m%d`-*.tar.gz $LOCAL_BACKUP_DIR
BACKUPRC=$?
if (( $BACKUPRC > 0 )); then
    echo "backup was not successful"
else
    echo "OK"
    find $BACKUP_DIRECTORY -name "*.tar.gz" -mtime +$NB_DAYS_TO_KEEP_FILES -print0 | xargs -0r rm -f
    echo -e "backups older than $NB_DAYS_TO_KEEP_FILES days have been removed. \n"
fi
