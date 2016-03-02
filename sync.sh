#!/usr/bin/expect -f
set timeout -1

set f [open "$env(COMMANDS_FILE)"]
set commands [split [read $f] "\n"]
close $f

foreach command $commands {
  spawn {*}$command
  expect "password:"
  send "$env(NCI_PASSWORD)\r"
  expect eof
}

