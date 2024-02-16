#!/bin/bash

# Ref : https://github.com/kodekloudhub/shell-scripting-for-beginners-course.git

# Running a shell script--------------------------------------------------------------------
bash create-and-launch-rocket.sh  # shell scripts executes line by line
sh create-and-launch-rocket.sh

# Defining shell script as a command

$ create-and-launch-rocket # how do we do this ?
# Note: Include this script to $PATH variable  by appending the script to the variable. And also remove .sh extension
$ export PATH=$PATH:/home/michael

# Exiting from a shell script
exit
exit 1 # this would return signal 1 , for any calling processes to identify it failed due to missing arguments
# port the errors 
echo "Error: Invalid Arguments" >&2 # prints the error message to standard error 'stderr' , which redirects the output to standard error

#----------------------Variables-------------------------------------------------------------------#
mission_name=mars-mission  #variables only can have alpha numeric values so - values not allowed
rocket_status=$(rocket-status $mission_name) # we can store output of another command in a variable
# best practice : variable names must be in lowercase with underscrores to seperate words
file_name="create-and-launch-rocket"
cp $file_name ${file_name}_bkp  # This is how you should encapsulate a variable so you could append the rest of the command. If the variable has been invoked within "" , then no problem you may use like $varible instead of ${variable}
$USER # This is an environment variable

#--------------------- Command Line Argument------------------------------------------------------#
$ create-and-launch-rocket saturn-mission # Here mission name has been passed as a command line argument
mission_name=$1 #first command line argument
# Note: Design the script in the mindset of reusability , use command line arguments to pass inputs
# commandline arguments are passed as strings in linux 

#--------------------- Read Input ----------------------------------------------------------------#
read mission_name # this way the cmdline will expect user input, however this does not prompt the user
mkdir $mission_name

read -p "Enter the mission Name: " mission_name
# Note to thought : A script should be re-usable , therefore using commandline arguments make the script inter-operable within other scripts. Having no user intervention
echo "Capital city of $1 is $2"


#--------------------- Arithmetic Operations -----------------------------------------------------#
# Method 1: Using expr

expr 6 + 3  # need a space between operator and number
expr 6 - 3  # need a space between operator and number
expr 6 / 3  # need a space between operator and number
expr 6 \* 3 # multipication requires escape charchter as well

A=6
B=3

expr $A + $B
expr $A - $B
expr $A / $B # does not retrun decimals, only integer
expr $A \* $B

# Method 2: Using (())

echo $(( A+B ))
echo $(( A-B ))
echo $(( A/B )) # does not return decimals, only integer
echo $(( A*B ))

echo $(( ++A )) # first added one and then value printed
echo $(( --A )) # like above
echo $(( A++ )) # first value A printed , then added one
echo $(( A-- ))

echo $A / $B | bc -l # returns decimal result , bc- basic calculator in linux , -l for floating point results

#--------------------- Conditional Logic -----------------------------------------------------#
# syntax:
if [condition]
then
    action to be performed
fi

# the condition of an if statement encapsulated in [[ ]]
# else if aka elif , else block can be added at the end
if [condition]
then
    action to be performed
elif [condition]
then
    2nd action to be performed
else
    execute this when either of above conditions are not met
fi

# comparisive statements [ string1 = string2 ] , should maintain a space between operators and encapsulated brackets
#? '=' or '!=' operator should only be used to compare strings 
# For numeric comparisons : -eq (equal) , -ne (not equal), -gt (greater than), -lt (less than) 

if [ $rocket_status = "failed" ]
then
  rocket-debug $mission_name
fi

# Method 2 of conditional operators which is available only bash
#* these are only available in Bash : https://github.com/kodekloudhub/shell-scripting-for-beginners-course/blob/master/docs/03-Flow-Control/01-Conditional-Logic.md#conditional-operators
[[ string1 = string2 ]]

# conditional operators
[ condition1 ] && [ condition2 ]
[ condition1 ] || [ condition2 ]
# example :
if [ $month_number -lt 1  ] || [ $month_number -gt 12 ]
then
    echo "Invalid month number given" >&2
    exit 2
fi
# some usecases
[ -z $mission_name ] # check if mission_name has a value , if there's no value returns TRUE
[ -e FILE ] # if file exists
[ -d FILE ] # if file exists and its a directory
[ -s FILE ] # if file exists and has size greater than 0
[ -x FILE ] # if the file executable
[ -w FILE ] # if the file is writable

#example : 
if [ -d /home/bob/caleston ]
then
        echo "Directory exists"
fi

#-------------------------------------------For Loop --------------------------------------------------------------------------

#Executing a Shell Script

# Arithmetic Operations

# Best Practices/IDEs

