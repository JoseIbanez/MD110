#!/usr/bin/expect -f
log_user 1
set timeout -1
set env(TERM)

spawn telnet [lindex $argv 0]
expect "login: "
send "SSSSSS;\r"
expect "USER NAME"
expect "<"
send "MDUSER\r"
expect "PASSWORD"
expect "<"
send "ICM0506\r"
expect "<"

set chan [open [lindex $argv 1] w]
send [lindex $argv 2]
send "\r"
expect "<"
puts $chan  "$expect_out(buffer)"
close $chan

send \x18
send "O;"



