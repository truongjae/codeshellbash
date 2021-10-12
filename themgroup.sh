#!/bin/bash
echo "Nhap ten nhom can tao moi : "
read group
grep $group /etc/group >/dev/null
if [ $? -eq 0 ]
	then
	echo "$group da ton tai"
else 
	groupadd -r $group
	echo "$group da duoc them"
	echo "Ban muon them user vao group $group khong?. (y/n)"
	read question
	while [ $question == 'y' ] || [ $question == 'Y' ] ||
	[ $question == 'n' ] || [ $question == 'N' ]
	do
		echo "Nhap ten user:"
		read user
		grep $user /etc/passwd >/dev/null
		if [ $? -eq 0 ]
		then
			echo "User $user da ton tai"
		else
			echo "Nhap mat khau: "
			read pw
			pass=$(perl -e ' printf crypt($ARGV[0], "password")' $pw)
			useradd -g $group -m -p $pass $user
			echo "Da them thanh cong"
		fi
		echo "Ban muon them user nua khong (y/n)"
		read question
		if [ $question == 'n' ] || [ $question == 'N' ]
		then
			exit 0
		fi
	done
fi
