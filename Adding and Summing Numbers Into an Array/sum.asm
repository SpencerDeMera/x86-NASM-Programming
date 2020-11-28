; ****************************************************************************************************************************
; Program name: "IEEE754 Area of Triangle". This program calculates the area of a triangle using IEEE754 floats              *
;  Copyright (C) 2020  Spencer DeMera                                             											  * 
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
; version 3 as published by the Free Software Foundation.                                                                    *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
; A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
; ****************************************************************************************************************************

; Author information
;  Author name: Spencer DeMera
;  Author email: spencer.demera@csu.fullerton.edu

; Program information
;  Program name: Area of Triangle
;  Programming languages: C++. X86, C.
;  Date program began: 11-9-2020
;  Date of last update: 10-
;  Comments reorganized: 10-
;  Files in the program: main.c, manager.asm, display_array.cpp, sum.asm, input_array.asm, atol.asm, validate-decimal0digits.cpp, r.sh

; Purpose
;  Compute the area of a triangle and print as an IEEE754 number.
;  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

; This file
; File name: manager.asm
; Language: x86_64 NASM
; Syntax: Intel
; Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
; Compile: nasm -f elf64 -l manager.lis -o manager.o manager.asm
; Link: gcc -m64 -no-pie -o arrays.out -std=c11 manager.o inputArray.o sum.o displayArray.o main.o

; Execution: ./arrays.out

; ===== Begin code area =====

global sum                             ; Makes function callable from other linked files.

section .data     

section .bss

;==========================================================================================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ====================================================================================
;==========================================================================================================================================================================

section .text

sum:

;============ Pushes ============
; Back up all registers to stack and set stack pointer to base pointer
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword -1                           ; Extra push onto stack to make even # of pushes.

;============ Initialize registers ============

mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0                              ; Sum register to add elements of array to.
mov r12, 0                              ; Counter to to iterate through array.

;============ beginloop ============
begin_loop:

cmp r12, r14                        
jge outofloop

;============ Copy to array block ============
add r13, [r15 + 8 * r12]            
inc r12                                 ; Increments counter r12 by 1.

; Restarts loop
jmp begin_loop          

;============ Endofloop ============
outofloop:

;============ Pushes ============
; Restores all backed up registers to their original state.
pop rax                                ; Remove extra push of -1 from stack.
mov qword rax, r13                     ; Copies sum (r13) to rax.
popf                                                       
pop rbx                                                     
pop r15                                                     
pop r14                                                      
pop r13                                                      
pop r12                                                      
pop r11                                                     
pop r10                                                     
pop r9                                                      
pop r8                                                      
pop rcx                                                     
pop rdx                                                     
pop rsi                                                     
pop rdi                                                     
pop rbp
;============ Return ============

ret