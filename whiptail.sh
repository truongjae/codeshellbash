#!/bin/bash
{
for((i=0;i<100;i+=20))
do
sleep 1
echo $i
done
} | whiptail --gauge "Vui long doi trong khi cai dat" 6 60 0
