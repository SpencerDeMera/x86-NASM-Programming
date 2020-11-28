#!/bin/bash
#In the official documemtation the line above always has to be the first line of any script file.

# Author: Spencer DeMera
# Email: spencer.demera@csu.fullerton.edu
# Course ID: CPSC 240-05
# Assignment Number: 5
# Due Date: 11/9/2020
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

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble atolong.asm"
nasm -f elf64 -l atolong.lis -o atolong.o atol.asm

echo "Compile display_array.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o display_array.o display_array.cpp -std=c++17

echo "Compile isinteger.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o isinteger.o validate-decimal-digits.cpp -std=c++17

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o array.out -std=c11 main.o manager.o input_array.o sum.o isinteger.o atolong.o display_array.o

echo "Run the program Array Example:"
./array.out
