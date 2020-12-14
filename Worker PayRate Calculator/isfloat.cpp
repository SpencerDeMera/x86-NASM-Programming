// This is a library function distributed without accompanying software.                                                      *
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public   *
// License version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be   *
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.*
// See the GNU General Public License for more details.  A copy of the GNU Lesser General Public License 3.0 should have been *
// distributed with this function.  If the LGPL does not accompany this software then it is available here:                    *
// <https:;www.gnu.org/licenses/>.
//
// Author information
// Author name: Bilal
//
// Program information
//  Program name: isfloat
//  Programming languages: 1 module in C++
//  Date program began: 2020-Nov-10
//  Date of last update: 2020-Nov-10
//  Status: This program was tested by the author many times.
//
// This file
//  Name: isfloat.cpp
//  Language: C++
//  Syntax: Intel
//  Assemble: g++ -c -m64 -Wall -fno-pie -no-pie -o isfloat.o isfloat.cpp
//
//  Purpose: check a given string to see if it is a float and return bool 1 for true and 0 for false
//
//
//===== Begin code area =======================================================================================
#include<stdio.h>
#include<string>
#include<cctype>
#include<math.h>

extern "C" bool isfloat(char[]);

bool isfloat(char digit[]){
    bool trueNumber = true;
    unsigned int dots = 0;
    long unsigned startIndex = 0;      //Used for index in for loop

   
        //Checking for any '+' or '-' on first index
        if(digit[0] == '+'){      //If negative or positive sign located, shift index up    
            startIndex++;
        }
        else if (!isdigit(digit[0])){
            trueNumber = false;
        }

        while(digit[startIndex] != '\0'){
            if(!isdigit(digit[startIndex])){
                if(digit[startIndex] == '.'){
                    //Decimal point found
                    dots++; 
                    if(dots > 1) trueNumber = false;        //If more than one decimal point is inputted. 
                }
                else trueNumber = false;
            }
            startIndex++;
        }
        
    return trueNumber;
}
