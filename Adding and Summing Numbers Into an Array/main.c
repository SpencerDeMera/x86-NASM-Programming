// ****************************************************************************************************************************
// Program name: "IEEE754 Area of Triangle". This program calculates the area of a triangle using IEEE754 floats              *
//  Copyright (C) 2020  Spencer DeMera                                             											  * 
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
// version 3 as published by the Free Software Foundation.                                                                    *
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
// A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
// ****************************************************************************************************************************

// Author information
//  Author name: Spencer DeMera
//  Author email: spencer.demera@csu.fullerton.edu

// Program information
//  Program name: Area of Triangle
//  Programming languages: C++. X86, C.
//  Date program began: 11-9-2020
//  Date of last update: 10-
//  Comments reorganized: 10-
//  Files in the program: main.c, manager.asm, display_array.cpp, sum.asm, input_array.asm, atol.asm, validate-decimal0digits.cpp, r.sh

// Purpose
//  Compute the area of a triangle and print as an IEEE754 number.
//  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

// This file
//  File name: main.c
//  Language: C
//  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
//  Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
//  Link: gcc -m64 -no-pie -o arrays.out -std=c11 manager.o inputArray.o sum.o displayArray.o main.o 

// Execution: ./arrays.out

// ===== Begin code area =====


#include <stdio.h>
#include <stdint.h>

long int manager();

int main() {
	long int result_code = -999;

	printf("%s","\nWelcome to Arrays of Integers\n");
	printf("%s","Brought to you by Bilal El-haghassan\n\n");

	result_code = manager();

	printf("%s%ld%s","\nMain received, ",result_code, " and is not sure what to do with it.\n");
	printf("%s","Main will return 0 to the operating system. Bye.\n\n");
	return 0;
} // main function
