#!/bin/bash

#variables
states=('California' 'Texas' 'Maine' 'New York' 'Nevada')
nums=$(echo {0..9})
ls_out=$(ls)
execs=$(find /home -type f -perm 777 2> /dev/null)

#for loop for state cali
for state in ${states[@]}
do
if [ $state == 'California' ];
then
echo "California is the best!"
else
echo "I'm not a fan of California"
fi
done

#for loop for nums 3, 5, and 7
for num in ${nums[@]}
do
if [ $num = 3 ] || [$num = 5 ] || [ $num = 7 ]
then
echo $num
fi
done

#for loop for ls that prints out each item in your variable that hold the ouput of the 'ls' command
for x in ${ls_out[@]}
do echo $x
done

#bonus create a for loop to print out execs on one line for each entry
for exec in ${execs[@]}
do
echo $exec
done
