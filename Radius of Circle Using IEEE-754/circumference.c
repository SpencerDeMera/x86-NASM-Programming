// ****************************************************************************************************************************
// Program name: "Circumference of Circle with Pi". This program takes an array of integers, swaps them, sorts them,      	*
//  and prints the array. Copyright (C) 2020  Spencer DeMera                                             					*     
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
//  Program name: circumference with pi
//  Programming languages: C++. X86, C.
//  Date program began: 10-28-2020
//  Date of last update: 11-9-2020
//  Comments reorganized: 11-9-2020
//  Files in the program: main.c, manager.asm, displayArray.cpp, sum.asm, inputArray.asm, run.sh

// Purpose
//  Compute the Sum of Integers and Print them as an Array.
//  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

// This file
//  File name: circumference.c
//  Language: C
//  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
//  Compile: gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11
//  Link: gcc -m64 -no-pie -o arrays.out -std=c11 manager.o inputArray.o sum.o displayArray.o main.o 

// Execution: ./arrays.out

// ============ Begin code area ============
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

double circle();

int main() {
	double result_code;
	printf("Welcome to your friendly circle circumference calculator.\n");
	printf("The main program will now call the circle function.\n\n");

	result_code = circle();

	void *q;
	double *p = malloc(1*sizeof(double));
	*p = result_code;
	unsigned long *r = 0;
	q = p;
	r = q;

	printf("%s%2.18lf = 0x%016lX.\n", "\nThe main recieved this number: ", *p, *r);
	printf("Have a nice day. Main will now return 0 to the operating system.\n");

	return 0;
} // main