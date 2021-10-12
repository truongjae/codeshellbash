#!/bin/bash
echo "nhap vao tai khoan user can kiem tra"
read user
tmp=$(grep $user:x /etc/passwd | wc -l)
if [ $tmp -eq 0 ]
then
	echo "Tai khoan $user khong ton tai trong he thong"
else
	echo "tai khoan $user co ton tai trong he thong"
	grep $user:x /etc/passwd
	k=$(who | grep $user | wc -l)
	if [ $k -ne 0 ]
	then
		echo "tai khoan $user dang login vao he thong"
	else
		echo "tai khoan $user khong login vao he thong"
	fi	
fi
