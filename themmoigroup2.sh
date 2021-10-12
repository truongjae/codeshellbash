#!/bin/bash
if [ $(id -u) -ne 0 ]
then
	echo "Bạn không phải là root"	
	exit 0
fi

read -p "Nhập tên nhóm: " gr
if grep -q $gr /etc/group
then
	echo "Nhóm $gr đã tồn tại"
	echo "Danh sách tài khoản trong nhóm $gr: $(getent group $gr | cut -d: -f4)"
	echo "Ban co muon xoa tat ca user khong (Y/N)"
	read qsdel
	if [ ${qsdel,,} == 'y' ]
	then
		i=1
		while [ $(sudo getent group $gr | cut -d: -f4 | cut -d, -f$i) ]
		do
			echo "Tài khoản $(sudo getent group $gr | cut -d: -f4 | cut -d, -f$i) đã bị xóa"
			sudo userdel $(sudo getent group $gr | cut -d: -f4 | cut -d, -f$i)
			i=`expr $i + 1`
		done
	else
		echo "Ban da chon khong xoa user nao"
	fi
else
	groupadd -r $gr
	echo "Thêm nhóm $gr thành công"
fi
	read -p "Thêm tài khoản vào nhóm $gr (Y/N)" qs
	while [ ${qs,,} == 'y' ]
	do
		read -p "Nhập tên tài khoản mới: " usr
		if grep -q $usr /etc/passwd
		then
			echo "Tài khoản $usr đã tồn tại"
		else
			read -s -p "Nhập mật khẩu: " pw
			echo ""
			pw=$(perl -e ' printf crypt($ARGV[0], "password")' $pw)
			useradd -g $gr -p $pw $usr
			echo "Đã thêm $usr thành công vào nhóm $gr"
		fi
		read -p "Bạn có muốn tiếp tục thêm tài khoản mới vào nhóm $gr không? (Y/N)" qs
		if [ ${qs,,} == 'n' ]
		then
			exit 0
		fi
	done

