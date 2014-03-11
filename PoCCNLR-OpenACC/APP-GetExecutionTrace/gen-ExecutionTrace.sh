#!/bin/sh

 awk '{print NR"@ "$0}' $1  > $1-withLN.c
 awk '/Tns/ ' $1-withLN.c  > TnsOnly
 rm $1-withLN.c
 awk -F ";" '{print $1" ;"}' TnsOnly  > ExecutionTrace
 sed -i 's/TnsMem[Wr|C|Iter]*/Trace/g' ExecutionTrace 
 python mask.py  ExecutionTrace > masked
 sed -i 's/ //g' masked
 sed -i 's/\t//g' masked
 mv masked ExecutionTrace
 rm TnsOnly
