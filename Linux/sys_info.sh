#!/bin/bash

#check if script was run as root. exit if false
if [ $UID -ne 0 ]
then
  echo "Please do not run this script as root."
  exit
fi

#define variables
output=$HOME/research/sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1)
execs=$(find /home -type f -perm 777 2> /dev/null)
cpu=$(lscpu | grep CPU)
disk=$(df -H | head -2)

#define lists to use later
commands=('date' 'uname -a' 'hostname -s')
files=('/etc/passwd' '/etc/shadow')

#check for research directory. create it if needed.
if [ ! -d $HOME/research ]
then
mkdir $HOME/research
fi

#check for output file. clear it if needed.
if [-f $output ]
then
rm $output
fi

############Start Script##################

echo "A Quick System Audit Script" >> $output
echo "" >> $output

for x in {0..2};
do
results=$(${commands[$x]})
echo "Results of \"${commands[$x]}\" command:"
echo $results
echo ""
done

#Display machine type
echo "Machine Type Info:" >> $output
echo $MACHTYPE >> $output

#Display IP Info
echo -e "IP Info:" >> $output
echo -e "ip \n" >> $output

#Display Memory Usage
echo -e "\nMemory Info:" >> $output
free >> $output

#Display CPU Usage
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output

#Display Disk Usage
echo -e "\nDisk Usage:" >> $output 
df -H | head -2 >> $output

#Display login information fo the current user
echo -e "\nWho is logged in: \n $(who -a) \n" >> $output

#Display DNS Info
echo -e "DNS Servers: " >> $output
cat /etc/resolv.conf >> $output

#List exec files
echo -e "\nexec Files:" >> $output
for exec in $exec;
do
echo $exec >> $output
done

#List of top 10 Processes
echo -e "\nTop 10 Processes" >> $output
ps aux -m | awk {'print $1, $2, $3, $4, $11'} | head >> $output

#Check the permissions on files
echo -e "\nThe permissions for sensitive /etc files: \n" >> $output
for file in ${files[@]}
do
ls -l $file >> $output
done

