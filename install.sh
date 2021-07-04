#!/usr/bin/bash

mkdir -p /home/trngxx/e\&r/unix/{project/{data,report,dev/{dept,emp,bin}},projbackup}

mv ./sh_files/{enquiry.sh,dept_maint_scrn.sh} /home/trngxx/e\&r/unix/project/dev/bin
mv ./sh_files/add_dept.sh /home/trngxx/e\&r/unix/project/dev/dept
mv ./sh_files/add_emp.sh /home/trngxx/e\&r/unix/project/dev/emp

#
cat ./sh_files/etc_prof_apnd.txt >> /etc/profile