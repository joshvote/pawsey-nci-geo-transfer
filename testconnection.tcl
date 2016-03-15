#!/usr/bin/expect -f
set timeout 5

spawn ssh "$env(NCI_USER)@$env(NCI_HOST)" "echo connection ok"
expect {
  "ermission denied" {exit 1}
  "assword:" {send "$env(NCI_PASSWORD)\r" ; exp_continue}
  timeout {exit 2}
  eof {exit 0}
}

