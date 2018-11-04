#!/bin/sh
DB_DATA_PATH="/data/mariadb"
DB_USER="a_fake_user_blabla6790"
DB_PASS="ThisisNotveryLongPWD790_12KLJ"
MAX_ALLOWED_PACKET="200M"

rm -rf "${DB_DATA_PATH}"

mkdir -p $DB_DATA_PATH ; chmod 777 $DB_DATA_PATH 
chown -R mysql:mysql ${DB_DATA_PATH}

mysql_install_db --skip-auth-anonymous-user --skip-name-resolve --user=mysql --datadir=${DB_DATA_PATH} > /dev/null

DB_ROOT_PASS=`pwgen 24 1`
   echo "                                       ╔════════════════════════════════════════════════════╗"
   echo "                    ------------------ ║                           ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ ║"
echo "$(date "+%Y-%m-%d %T") ------------------ ║ [i] MySQL root Password:  $DB_ROOT_PASS ║"
   echo "                    ------------------ ║                           ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ ║"
   echo "                                       ╚════════════════════════════════════════════════════╝"
tfile=`mktemp`
if [ ! -f "$tfile" ]; then
    return 1
fi

cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS' WITH GRANT OPTION;
DROP DATABASE test;
EOF

/usr/bin/mysqld --user=mysql --bootstrap --verbose=1 < $tfile
rm -f $tfile

mkdir -p /data/logs ; chmod 777 /data/logs ; touch /data/logs/mysql.log /data/logs/mysql-slow.log; chmod 666 /data/logs/mysql.log /data/logs/mysql-slow.log

tail -f /data/logs/mysql.log &

exec /usr/bin/mysqld --user=mysql --console

