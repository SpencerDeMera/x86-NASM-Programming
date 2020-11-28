#!/bin/bash

#Program: Circumference of Circle
#Author: Spencer DeMera

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble circle.asm"
nasm -f elf64 -l circle.lis -o circle.o circle.asm

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o a.out -std=c11 circle.o main.o

echo "----- Run the program -----\n"
#chmod u+x ./a.out
./a.out

echo "\n----- Program finished -----"