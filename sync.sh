#!/usr/bin/expect -f
set timeout -1
spawn rsync -W -t *.nc $1@raijin.nci.org.au:$3
expect "password:"
send "$2\r"
expect eof

