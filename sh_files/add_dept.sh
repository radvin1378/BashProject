#!/usr/bin/bash

difseg "="

ant=y
until [ $ant = n ]; do
    
    echo -e "\e[4m\e[1mAdd Department\e[0m\e[0m\n"   #Bold & underline

    read -p "Enter Department name: " DeptN
    
    #checks if Department Name is VALID
    if [ `echo "$DeptN" | tr -d '\n' | wc -c` -ge 15 ]; then
        printf "\n%s\n" "ERROR: Department name should be less than 15 characters" > /dev/stderr
        read -n1
    #checks if department data is already eneterd
    elif grep -i "^$DeptN$" /home/trngxx/e\&r/unix/project/data/dept.dat > /dev/null ; then
        printf "%s" "\nDepartment data is already entered\n"
        read -n1
    #checks if dept.dat file is empty 
    elif [ -s /home/trngxx/e\&r/unix/project/data/dept.dat ]; then
        DeptC=`tail -n1 /home/trngxx/e\&r/unix/project/data/dept.dat | cut -d":" -f1`
        ((DeptC++))
        echo Department Code: $DeptC
        echo "$DeptC:$DeptN" >> /home/trngxx/e\&r/unix/project/data/dept.dat
    else 
        DeptC=1000
        echo Department Code: $DeptC
        echo "$DeptC:$DeptN" >> /home/trngxx/e\&r/unix/project/data/dept.dat
    fi

    echo        
    read -p "Add another department? [y/n] " ant
    ant=`echo $ant | tr [:upper:] [:lower:]`

    #check if input is VALID
    until [ $ant = y -o $ant = n ];do
        echo "Please enter yes(y) or no(n)" > /dev/stderr
        echo
        read -p "Add another department? [y/n] " ant
        ant=`echo $ant | tr [:upper:] [:lower:]`
    done
    #to differnetiate sections
    if [ $ant = y ]; then
        difseg "-"
    fi

done

difseg "="
showmenu