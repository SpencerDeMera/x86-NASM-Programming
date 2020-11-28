#!/bin/bash
#In the official documemtation the line above always has to be the first line of any script file.

# Author: Spencer DeMera
# Email: spencer.demera@csu.fullerton.edu
# Course ID: CPSC 240-05
# Assignment Number: 4
# Due Date: 11/14/2020
# Purpose: Homework && Extra Credit

#This is a bash shell script to be used for compiling, linking, and executing the C, C++, & x86 NASM files of this assignment.
#Execute this file by navigating the terminal window to the folder where this file resides, and then enter either of the commands below:
#  sh run.sh   OR   ./build.sh

#System requirements:
#  A Linux system with BASH shell (in a terminal window).
#  The mono compiler must be installed.  If not installed run the command "sudo apt install mono-complete" without quotes.
#  The source files and this script file must be in the same folder.
#  This file, run.sh, must have execute permission.  Go to the properties window of build.sh and put a check in the
#  permission to execute box.

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble circle.asm"
nasm -f elf64 -l circle.lis -o circle.o circle.asm

echo "Compile circumference.c"
gcc -c -Wall -m64 -no-pie -o circumference.o circumference.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o circ.out -std=c11 circle.o circumference.o

echo "----- Run the program -----\n"
#chmod u+x ./a.out
./circ.out

echo "\n----- Program finished -----"