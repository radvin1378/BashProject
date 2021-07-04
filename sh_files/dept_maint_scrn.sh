#!/usr/bin/bash

#Fn to seperate segemnts
difseg () {
    local i=1
    while [ $i -le `tput cols` ]; do
    echo $1 | tr -d '\n'
    ((i++))
    done 
}
#Fn to show menu
showmenu () {
    echo -e "\e[4m\e[1mDepartment Maintenance Screen\e[0m\e[0m\n"   #Bold & underline
    echo "1) Department"
    echo "2) Employee"
    echo "3) Enquiry"
    echo "4) quit"
}
#prompt when Ctrl + c is pressed
quit() {
    echo -e "\n"
    read -p "Do you want to quit ? [y/n] " n
    n=`echo $n | tr [:upper:] [:lower:]`
    if [ "$n" = 'y' ]; then
        difseg
        exit
    fi
}
trap quit SIGINT


#mkworkdir

#creates backup of all files at project level
runbackup () {
    if [ -e projbackup\<`date +%F`\>.gz ]; then
        read -p "backup file already exist, Do you want to overwrite it? [y/n] " ans
        case $ans in
            [yY])rm ./backup/projbackup\<`date +%F`\>.gz
            tar -czvf projbackup\<`date +%F`\>.gz ./data/
            mv projbackup\<`date +%F`\>.gz ./backup/ ;;
            
            [nN]) echo backup cancelled;;
            *) echo INVALID input;;
        esac
    else
        tar -czvf projbackup\<`date +%F`\>.gz ./data/
        mv projbackup\<`date +%F`\>.gz ./backup/
    fi
}
#Creates .dat file at login
if ! [ -e /home/trngxx/e\&r/unix/project/data/dept.dat -a -e /home/trngxx/e\&r/unix/project/data/emp.dat ];then
    touch /home/trngxx/e\&r/unix/project/data/dept.dat /home/trngxx/e\&r/unix/project/data/emp.dat
fi
#--------------------------------------------------------------------------
difseg "="

echo -e "\e[4m\e[1mDepartment Maintenance Screen\e[0m\e[0m\n"   #Bold & underline

PS3="Enter your choice: "
options=("Department" "Employee" "Enquiry" "quit")

select x in ${options[@]}; do
    case $x in
        Department) . /home/trngxx/e\&r/unix/project/dev/dept/add_dept.sh;;
        Employee) . /home/trngxx/e\&r/unix/project/dev/emp/add_emp.sh;;
        Enquiry) . /home/trngxx/e\&r/unix/project/dev/bin/enquiry.sh;;
        quit) difseg "=";exit;;
        *) echo -e "\nERROR: Valid choices should be entered.\n";read -n1;;
    esac
done