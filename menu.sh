#!/bin/bash
while :
do
clear
echo "DANH MUC MENU"
echo "1. Hien thi ngay va thoi gian"
echo "2. Hien thi cac thu muc, tep tin va cho phep xoa(neu co)"
echo "3. Hien thi tai khoan nguoi dung (User)"
echo "4. Hien thi nhom nguoi dung (Group)"
echo "5. Hien thi cac User dang hoat dong"
echo "6. Hien thi ket noi mang (router)"
echo "7. Kiem tra dia chi IP cua may chu"
echo "8. Ping IP xem co ket noi mang hay khong"
echo "9. Thuc hien them tai khoan nguoi dung vao he thong"
echo "10. Thuc hien them tai khoan nhom vao he thong"
echo "11. Hien thi cac dai mang con ket noi den may chu"
echo "12. Hien thi DHCP"
echo "13. Hien thi cac dich vu"
echo "--------------"
echo "100. Thoat chuong trinh"
echo "--------------"
echo "Vui long chon gia tri tu 1-100 :"
read chon
case $chon in
	1) echo "Ngay hom nay la: $(date)"
	;;
	2) echo "Ban da chon bai 2";;
	3) cat /etc/passwd
	;;
	4) cat /etc/group
	;;
	5) who
	;;
	6) netstat -nat
	;;
	7) ifconfig -a
	;;
	8) if ping -q -c 1 -W 1 8.8.8.8 >/dev/null
	then
		echo "IPv4 dang hoat dong"
	else
		echo "IPv4 khong hoat dong"
	fi
	;;
	9)
	
	;;
	10)

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
	;;
	11)
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
	12)
	dhclient
	;;
	13)
	service --status-all
	;;
	100) echo "Tam biet"
	exit 0
	;;
	*)
	echo "Loi ban chi duoc lua chon tu 1-4"
;;
esac
read -p "Nhan phim enter de tiep tuc..."
readEnterKey
done
