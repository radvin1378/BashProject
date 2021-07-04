#!/usr/bin/bash

difseg "="

ant=y
until [ $ant = n ]; do
    echo -e "\e[4m\e[1mEnquiry\e[0m\e[0m\n"   #Bold & underline
    read -p "Enter the Department code: " DeptC

    #if the entered Dept code is VALID
    if grep "^$DeptC:" /home/trngxx/e\&r/unix/project/data/dept.dat > /dev/null;then
        echo "Department Name: `grep "$DeptC" /home/trngxx/e\&r/unix/project/data/dept.dat | cut -d":" -f2`" | tee -a /home/trngxx/e\&r/unix/project/report/temp.rep    #outputs Dept name to both STDOUT and temp.rep
        echo >> /home/trngxx/e\&r/unix/project/report/temp.rep
        echo -e "\n\e[4mDetails\e[0m:\n"

        SAVEIFS=$IFS   # Save current IFS
        IFS=':'      # Change IFS to colon
        EnqA=(`sort -t ':' -k2 /home/trngxx/e\&r/unix/project/data/emp.dat | grep ":$DeptC:" | tr '\n' ':'`)
        IFS=$SAVEIFS   # Restore IFS
            
        format_hd="%-10s\t%-25s\t%-15s\t%-15s\n"   #header format
        format_cont="%-10d\t%-25s\t%-15d\t%-15s\n"   #content format

        printf "$format_hd" "Emp ID" "Employee Name" "Dept Code" "Location"  | tee -a /home/trngxx/e\&r/unix/project/report/temp.rep #print header
            
        i=1;while [ $i -le 78 ]; do echo - | tr -d '\n' | tee -a /home/trngxx/e\&r/unix/project/report/temp.rep; ((i++)); done;echo  | tee -a /home/trngxx/e\&r/unix/project/report/temp.rep;   #print ---

        #print content
        for ((i=0; i < ${#EnqA[@]}; i+=4)); do
            printf "$format_cont" "${EnqA[$i]}" "${EnqA[`expr $i + 1`]}" "${EnqA[`expr $i + 2`]}" "${EnqA[`expr $i + 3`]}"  | tee -a /home/trngxx/e\&r/unix/project/report/temp.rep
        done
        echo >> /home/trngxx/e\&r/unix/project/report/temp.rep

    #If Dept Code INVALID
    else
        read -p "Department doesn't exist" -n1
        
    fi

    echo
    read -p "Enquire by another department? [y/n] " ant
    ant=`echo $ant | tr [:upper:] [:lower:]`

    #check if input is VALID
    until [ $ant = y -o $ant = n ];do
        echo "Please enter yes(y) or no(n)"
        echo
        read -p "Enquire another department? [y/n] " ant
        ant=`echo $ant | tr [:upper:] [:lower:]`
    done
    #to differnetiate sections
    if [ $ant = y ]; then
        difseg "-"
    else    #checks modified time of dept.rep
        tm=`date +%s -r /home/trngxx/e\&r/unix/project/report/temp.rep`
        dm=`date +%s -r /home/trngxx/e\&r/unix/project/report/dept.rep`
        interval=`expr $tm - $dm`
        if [ $interval -lt 600 ]; then  #if interval less than 10 mins
            rm /home/trngxx/e\&r/unix/project/report/temp.rep
        else
            cat /home/trngxx/e\&r/unix/project/report/temp.rep > ./home/trngxx/e\&r/unix/project/report/dept.rep
            rm /home/trngxx/e\&r/unix/project/report/temp.rep
        fi
    fi
done

difseg "="
showmenu