#!/bin/bash
echo "Nhap ten nhom can tao moi : "
read group
grep $group /etc/group >/dev/null
if [ $? -eq 0 ]
	then
	echo "$group da ton tai"
	echo "Danh sach tai khoan $(getent group $group | cut -d: -f4)"
	echo "Ban co muon xoa tat ca user khong(Y/N)?"
	read question
	if [ $question == 'y' ] || [ $question == 'Y' ]
	then
		i=1
		while [ $(sudo getent group $group | cut -d: -f4 | cut -d, -f$i) ]
		do
			sudo userdel $(sudo getent group $group | cut -d: -f4 | cut -d, -f$i)
			i=`expr $i + 1`
			echo "da xoa tat ca"
		done
		echo "da xoa tat ca"
	fi
		echo "Ban muon them user vao group $group khong?. (y/n)"
		read question
			if [ $question == 'y' ] || [ $question == 'Y' ]
			then
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
			if [ $question == 'n' ] || [ $question == 'N' ]
			then
				exit 0
			fi
else 
	groupadd -r $group
	echo "$group da duoc them"
	echo "Ban muon them user vao group $group khong?. (y/n)"
		read question
		if [ $question != 'y' ] || [ $question != 'Y' ] ||
			[ $question != 'n' ] || [ $question != 'N' ]
		then
			while [ $question != 'y' ] || [ $question != 'Y' ] ||
			[ $question != 'n' ] || [ $question != 'N' ]
			do
				echo "Ban vui long nhap lai"
				read question
			done
		else
			if [ $question == 'y' ] || [ $question == 'Y' ]
			then
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
			if [ $question == 'n' ] || [ $question == 'N' ]
			then
				exit 0
			fi
		fi
		
fi
