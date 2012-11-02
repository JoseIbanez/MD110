#!/usr/bin/expect -f
log_user 1
set timeout 3
set env(TERM)

#Fichero de ordenes
set fhandle [open [lindex $argv 1] r]

#Logado y sudo a root
spawn ssh -o StrictHostKeyChecking=no eri_sn_admin@[lindex $argv 0]
expect "Password: "
send "[lindex $argv 2]\r"
expect ">"
send "sudo -s\r"
expect {
        -re "assword:" {
                send "[lindex $argv 2]\r"
        }
        -re "#" {
                send "\r"
        }
}
expect "#"


set chan [open NULL w]

while {[gets $fhandle inline] >= 0} {
       if {[lindex $inline 0] == "@L"} {
         close $chan
         set chan [open [lindex $argv 0]-[lindex $inline 1] w]
       } {
         send $inline
         send "\n"
         expect {
            full_buffer {
                        puts -nonewline $chan  "$expect_out(buffer)"
                        exp_continue
                        }
            "_admin #"  {
                        puts -nonewline $chan  "$expect_out(buffer)"
                        }
            }
       }
}
close $chan
close $fhandle

