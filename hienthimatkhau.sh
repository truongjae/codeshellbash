#!bin/bash
password=$(whiptail --title "Dang nhap tai khoan" --passwordbox "Nhap mat khau va nhan ok de tiep tuc" 10 60 3>&1 1>&2 2>&3)
tmp=$?
if [ $tmp -eq 0 ]
then
	echo "mat khau la: $password"
else
	echo "Ban da chon cancel"
fi

