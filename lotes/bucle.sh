#!/bin/bash

lote=$1
user=$2
pass=$3

while read line
do
./ruby-lote.sh $line $lote $user $pass
#echo $line $lote $user $pass
done