#!/bin/bash
#In the official documemtation the line above always has to be the first line of any script file.

# Author: Spencer DeMera
# Email: spencer.demera@csu.fullerton.edu
# Course ID: CPSC 240-05
# Assignment Number: Final Exam
# Due Date: 12-14-2020
# Purpose: Final Exam

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

echo "Assemble compute.asm"
nasm -f elf64 -l compute.lis -o compute.o compute.asm

echo "Compile grosspay.c"
gcc -c -Wall -m64 -no-pie -o grosspay.o grosspay.c -std=c11

echo "Compile isfloat.cpp"
g++ -c -Wall -m64 -std=c++14 -no-pie -o isfloat.o isfloat.cpp

echo "Link the object files"
gcc -m64 -no-pie -o paycalc.out -std=c11 compute.o isfloat.o grosspay.o

echo "\n----- Run the program -----\n"
./paycalc.out

echo "\n----- Program finished -----\n"