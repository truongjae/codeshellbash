#!/bin/bash
while :
do
clear
echo "DANH MUC MENU"
echo "1. Tao 1 Group moi cho phep them nhieu tai khoan user moi (ten,matkhau)"
echo "2. Cho biet co bao nhieu tai khoan user co ma UID tu 600-900"
echo "3. Kiem tra user bat ky co dang Login vao he thong hay khong"
echo "4. Hien thi nhung tai khoan user co tu khoa ABC"
echo "5. Hien thi tat ca cac thu muc/tap tin cua Desktop va cho phep xoa bat ky thu muc/tap tin"
echo "6. Hien thi tat ca cac file cau hinh cua he thong"
echo "7. Cho biet dia chi IP cua server va Hien thi tat ca cac service cua server"
echo "8. Hien thi cac mang ket noi den server"
echo "9. Cho biet thong tin cua HDH, CPU, Memory, dung luong o dia..."
echo "--------------"
echo "10. Thoat"
echo "--------------"
echo "Vui long chon gia tri tu 1-10 :"
read chon
case $chon in
	1)
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
					break
				fi
			done
		fi
	fi
	;;
	2)
	s=0
	for((i=600;i<=900;i++))
	do
	if [ $(cat /etc/passwd | cut -d: -f3 | grep $i) ]
	then
		s=$(($s+$i))
	fi
	done
	echo "so luong user co UID 600-900: $s user"
	;;
	3) 
	echo "Nhap user can kiem tra: "
	   read tenuser
	   grep $tenuser:x /etc/passwd
	   kt=$(who | grep $tenuser | wc -l)
	   if [ $kt -ne 0 ]
	   then
	   	echo "User $tenuser dang login vao he thong"
	   else
	   	echo "User $tenuser khong login vao he thong"
	   fi
	   ;;
	4)
	grep "ABC" /etc/passwd >/dev/null
	if [ $? -eq 0 ]
	then
	echo "Danh sach tai khoan co chua ABC"
	echo $(cat /etc/passwd | grep "ABC" | cut -d: -f1)
	else
	echo "khong co user nao"
	fi
	;;
	5)
	ls Desktop
	echo "1. Xoa thu muc"
	echo "2. Xoa file"
	read delete
	case $delete in
		1)
		echo "Nhap vao ten thu muc muon xoa: "
		read folder
		rm -r Desktop/$folder
		echo "Xoa thanh cong"
		;;
		2)
		echo "Nhap vao ten file muon xoa: "
		read file
		rm Desktop/$file
		echo "Xoa thanh cong"
		;;
		*)
		echo "lua chon khong hop le"
		;;
		esac
	;;
	6) ls -al /etc/ | grep .conf
	;;
	7) ifconfig -a
	;;
	8)
	is_alive_ping()
	{
		ping -c 1 $1 >/dev/null
		[ $? -eq 0 ] && echo Dia chi IP $i dang hoat dong
	}
	for i in 192.168.169.{1..255}
	do
		is_alive_ping $i & disown
	done
	;;
	9)
	echo "Thong tin he dieu hanh"
	cat /etc/os-release
	echo "Thong tin CPU"
	cat /proc/cpuinfo
	echo "Thong tin Memory"
	cat /proc/meminfo
	du
	df
	free
	;;
	10)
	echo "Tam biet"
	exit 0
	;;
	*)
	echo "Loi ban chi duoc lua chon tu 1-10"
;;
esac
read -p "Nhan phim enter de tiep tuc..."
readEnterKey
done
