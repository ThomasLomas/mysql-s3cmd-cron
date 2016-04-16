#!/bin/sh

databases=`mysql -hmysql -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
BACKUP_DIR="/root/$TIMESTAMP"

mkdir "$BACKUP_DIR"

for db in $databases; do
    mysqldump --force --opt --host=mysql --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db > "$BACKUP_DIR/$db.sql"
done

tar -cpzf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"
s3cmd put "$BACKUP_DIR.tar.gz" "$AWS_BUCKET"
rm -f "$BACKUP_DIR $BACKUP_DIR.tar.gz"
