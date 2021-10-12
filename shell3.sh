#!/bin/bash
echo "nhap vao nam: "
read nam
can=`expr $nam % 10`
chi=`expr $nam % 12`
echo "$can"
echo -n "CAN "
case "$can" in
   0) echo "CANH" 
   ;;
   1) echo "TAN" 
   ;;
   2) echo "NHAM" 
   ;;
   3) echo "QUY" 
   ;;
   4) echo "GIAP" 
   ;;
   5) echo "AT" 
   ;;
   6) echo "BINH" 
   ;;
   7) echo "DINH" 
   ;;
   8) echo "MAU" 
   ;;
   9) echo "Ky" 
   ;;
esac
echo -n "CHI "
case "$chi" in
   0) echo "THAN" 
   ;;
   1) echo "DAU" 
   ;;
   2) echo "TUAT" 
   ;;
   3) echo "HOI" 
   ;;
   4) echo "TY" 
   ;;
   5) echo "SUU" 
   ;;
   6) echo "DAN" 
   ;;
   7) echo "MAO" 
   ;;
   8) echo "THIN" 
   ;;
   9) echo "TI" 
   ;;
   10) echo "NGO" 
   ;;
   11) echo "MUI" 
   ;;
esac
