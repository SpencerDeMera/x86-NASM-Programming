// ****************************************************************************************************************************
// Program name: "Final Exam". This program takes in user input to compute pay rates of a worker     	*
// Copyright (C) 2020  Spencer DeMera                                             					*     
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
//  Program name: Final Exam
//  Programming languages: C++. X86, C.
//  Date program began: 12-14-2020
//  Date of last update: 12-14-2020
//  Comments reorganized: 12-14-2020
//  Files in the program: grosspay.c, compute.asm, isfloat.cpp, run.sh

// Purpose
//  Compute the Pay of a worker
//  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

// This file
//  File name: grosspay.c
//  Language: C
//  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
//  Compile: gcc -c -Wall -m64 -no-pie -o grosspay.o grosspay.c -std=c11
//  Link: gcc -m64 -no-pie -o paycalc.out -std=c11 compute.o isfloat.o grosspay.o

// Execution: ./paycalc.out

// ============ Begin code area ============
#include <stdio.h>

double pay();

int main() {
	double result_code;

	printf("CPSC 240-5 Final\n");
	printf("**Shut Down Message DO NOT Work**\n\n");
	result_code = pay();

	printf("%s%.2f%s", "\nThe driver recieved this number : ", result_code, " and will keep it.\n");
	printf("Bye.\n");
	return 0;
} // main
