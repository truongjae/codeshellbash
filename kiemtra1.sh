#!/bin/bash
if [ $(id -u) -eq 0 ]
then
	echo "Nhap ten nguoi dung : "
	read user
	grep $user /etc/passwd >/dev/null
	if [ $? -eq 0 ]
	then
		echo "$user da ton tai tren he thong"
		exit 1
	else
		echo "Nhap mat khau cua nguoi dung : "
		read -s pw
		pass=$(perl -e 'printf crypt($ARGV[0], "password")' $pw)

		useradd -m -p $pass $user
		[ $? -eq 0 ] && echo "User $user da duoc them vao he thong" || echo "Loi them nguoi dung"
	fi
else
	echo "chi co admin moi co quyen them user vao he thong"
	exit 2
fi
