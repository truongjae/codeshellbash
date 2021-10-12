#!/bin/bash
tong=0
echo "Nhap so km:"
read n
for((i=1;i<=$n;i++))
do
if [ $i -le 1 ]
then
tong=$(($tong+10000))
fi
if [ $i -ge 2 ] && [ $i -le 10 ]
then
tong=$(($tong+8000))
fi
if [ $i -ge 11 ]
then
tong=$(($tong+7000))
fi
done
echo "tong tien $tong"



