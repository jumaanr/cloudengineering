#!/bin/bash

# Ref : https://github.com/kodekloudhub/shell-scripting-for-beginners-course.git

# Running a shell script--------------------------------------------------------------------
bash create-and-launch-rocket.sh  # shell scripts executes line by line
sh create-and-launch-rocket.sh

# Defining shell script as a command

$ create-and-launch-rocket # how do we do this ?
# Note: Include this script to $PATH variable  by appending the script to the variable. And also remove .sh extension
$ export PATH=$PATH:/home/michael


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

#Control Logic

#Loops

#Executing a Shell Script

# Arithmetic Operations

# Best Practices/IDEs

