#!/usr/bin/bash

difseg "="

ant=y
until [ $ant = n ]; do
    
    echo -e "\e[4m\e[1mAdd an Employee\e[0m\e[0m\n"   #Bold & underline

    read -p "Enter the name: " EmpN
    if [ -s /home/trngxx/e\&r/unix/project/data/emp.dat ]; then
        EmpC=`tail -n1 /home/trngxx/e\&r/unix/project/data/emp.dat | cut -d ":" -f1`
        ((EmpC++))
    else
        EmpC=1000
    fi
    printf "%s" "Employee ID: $EmpC\n\n"

    cat /home/trngxx/e\&r/unix/project/data/dept.dat
    echo
    read -p "Enter the Department code: " DeptC
    echo "Department Name: " `grep "^$DeptC:" /home/trngxx/e\&r/unix/project/data/dept.dat | cut -d ":" -f2`

    echo
    read -p "Enter the Location: " Loc

    #check if employee data is valid
    if [ `echo $EmpN | tr -d '\n' | wc -c` -gt 25 ]; then
        echo
        read -n1 -p "Name should be less than 25 characters"
    elif ! grep "^$DeptC:" /home/trngxx/e\&r/unix/project/data/dept.dat > /dev/null; then
        echo
        read -n1 -p "Only existing department code should be given"
    elif [ `echo $Loc | tr -d '\n' | wc -c` -gt 15 ]; then
        echo
        read -n1 -p "Location should be less than 15 character"
    else
        echo "$EmpC:$EmpN:$DeptC:$Loc" >> /home/trngxx/e\&r/unix/project/data/emp.dat   #updating file
    fi
    
    echo        
    read -p "Add another employee? [y/n] " ant
    ant=`echo $ant | tr [:upper:] [:lower:]`
     
    #check if input is VALID
    until [ $ant = y -o $ant = n ];do
        echo
        echo "Please enter yes(y) or no(n)"
        read -p "Add another employee? [y/n] " ant
        ant=`echo $ant | tr [:upper:] [:lower:]`
    done
    #to differnetiate sections
    if [ $ant = y ]; then
        difseg "-"
    fi

done

difseg "="
showmenu