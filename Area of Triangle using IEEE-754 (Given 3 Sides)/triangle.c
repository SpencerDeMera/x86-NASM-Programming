// ****************************************************************************************************************************
// Program name: "Area of Triangle with IEEE754". This program takes 3 userinputs for lengths of the sides of triangle,      	*
// calculates the area of said triangle, and prints it. Copyright (C) 2020  Spencer DeMera                                             					*     
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
//  Date program began: 11-22-2020
//  Date of last update: 11-24-2020
//  Comments reorganized: 11-24-2020
//  Files in the program: triangle.c, area.asm, isfloat.cpp, run.sh

// Purpose
//  Compute the area of a triangle given userinput.
//  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

// This file
//  File name: triangle.c
//  Language: C
//  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
//  Compile: gcc -c -Wall -m64 -no-pie -o triangle.o triangle.c -std=c11
//  Link: gcc -m64 -no-pie -o area.out -std=c11 area.o isfloat.o atof.o triangle.o 

// Execution: ./area.out

// ============ Begin code area ============
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

double area();

int main() {
	double result_code;
	printf("Welcome to Area of Triangles by Spencer DeMera.\n");
	printf("\nThis program will compute the area of your triangle.\n\n");

	result_code = area();

	void *q;
	double *p = malloc(1*sizeof(double));
	*p = result_code;
	unsigned long *r = 0;
	q = p;
	r = q;

	printf("%s0x%016lX%s\n", "\nThe driver recieved this number: ", *r, "and will keep it.");
	printf("\nNow 0 will be returned to the operating system. Bye.\n");

	return 0;
} // main

