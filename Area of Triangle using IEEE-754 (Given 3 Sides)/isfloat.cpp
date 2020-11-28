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

#include <cstdlib>
#include <ctype.h> 

using namespace std;

extern "C" bool isfloat(char []);

bool isfloat(char w[]) 
{
    bool result = true; // Assume floating number until proven otherwise.
    bool found = false; // Checks if only 1 decimal is entered.
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while( !(w[k]=='\0') && result )
        {
            if ((w[k] == '.') && !found) { found = true; 
            }
            else { result = result && isdigit(w[k]);
            }
            k++;
        }
    return result && found;
}
