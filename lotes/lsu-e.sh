#!/usr/bin/expect

set timeout 20
set name [lindex $argv 0]

set flog [open "LSU-E-$name.log" "w"]

set user "root"
set password "root123"


spawn telnet "$name" 

expect "login:" 
send "$user\n" 

expect "Password:" 
send "$password\n" 

expect "# "
send "ifconfig\n"

expect "# "
puts $flog $expect_out(buffer)

send "exit\n"

expect eof



