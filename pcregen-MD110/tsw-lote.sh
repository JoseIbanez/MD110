#!/usr/bin/expect -f
log_user 1
set timeout -1
set env(TERM)

set fhandle [open [lindex $argv 1] r]

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

set chan [open NULL w]

while {[gets $fhandle inline] >= 0} {
       
       
       if {[lindex $inline 0] == "@L"} {      
         close $chan
         set chan [open [lindex $inline 1] w] 
         
         
       } {
       
         send $inline
         send "\n"
         expect {
            full_buffer {
                        puts -nonewline $chan  "$expect_out(buffer)"
                        exp_continue
                        }  
            "<"         {  
                        puts -nonewline $chan  "$expect_out(buffer)" 
                        }
            }
       }  
}
close $chan
close $fhandle

send \x18
send "O;"
