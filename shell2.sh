#!/bin/bash
echo "nhap username: "
read user
echo "nhap password: "
read pass
if [[ ( $user -eq "admin" && $pass -eq "123" ) ]]
then
	echo "Dang nhap thanh cong"
else
	echo "Dang nhap khong thanh cong"
fi
