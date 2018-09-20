#! /bin/bash 

# ls_date=`date +%Y%m%d`

ls_date=`date +%Y%m%d%H%M%S`

mysqldump -uroot -p123456 -h127.0.0.1 laravel > /cpsite/docs/laravel${ls_date}.sql

# mysqldump -h 127.0.0.1 -uroot -p123456  -d laravel > dump.sql
