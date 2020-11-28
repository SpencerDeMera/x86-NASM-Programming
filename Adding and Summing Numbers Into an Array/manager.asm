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

extern printf
extern scanf
extern input_array
extern display_array
extern sum

array_size equ 100                  ; Capacity limit for number of elements allowed in array.

global manager                     ; Makes function callable from other linked files.

;===== Declare some messages ==============================================================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.  They are not variables.  They are not constants.  There are no constants in
;assembly programming.  There are no variables in assembly programming: the registers assume the role of variables.

section .data
    intructions db "This program will sum your array of integers", 10, 
                db "Enter a sequence of long integers separated by white space.", 10, 
                db "After the last input press enter followed by Control+D :", 10, 0
    numsreceived db 10, "These numbers were received and placed into the array:", 10, 0
    stringNumFormat db "The sum of the %ld numbers in this array is %ld.", 10, 0
    sumprompt db 10, "The sum will now be returned to the main function.", 10, 0
    stringFormat db "%s", 0 

section .bss
    intArray: resq 100                  ; Uninitialized array with 100 reserved qwords.

;==========================================================================================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ====================================================================================
;==========================================================================================================================================================================

section .text

manager:

; Back up all registers and set stack pointer to base pointer
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

push qword -1                           ; Extra push to create even number of pushes

;=========== Show the initial messages ==================
mov qword r14, 0                        ; Reserve register for number of elements in array.
mov qword r13, 0                        ; Reserve register for Sum of integers in array

mov qword rdi, stringFormat                     
mov qword rsi, intructions              
mov qword rax, 0
call printf                             ; Prints out intructionS prompt.

;=========== Call a function that will input some numbers into the array ===============
mov qword rdi, intArray                 ; Passes array into rdi register.
mov qword rsi, array_size               ; Passes the max array size into rsi register.
mov qword rax, 0
call input_array                        ; Calls funtion input_array.
mov r14, rax                            ; Saves copy of input_array output into r14.

;========== Identify the data that will be displayed ======================
mov qword rdi, stringFormat
mov qword rsi, numsreceived
mov qword rax, 0
call printf                             ; Prints out received confirmation

;=========== Show the contents recently placed into the array r14 ===================
mov qword rdi, intArray                 ; Passes the array as first parameter.
mov qword rsi, r14                      ; Passes # of elements in the array stored in r14.
mov qword rax, 0
call display_array                      ; Calls display_array function.

;=========== Calls Sum ============
mov qword rdi, intArray                 ; Passes the array as first parameter.  
mov qword rsi, r14                      ; Passes # of elements in the array stored in r14.
mov qword rax, 0
call sum                                ; Function sum to add all the integers in array. 
mov r13, rax                            ; Saves a copy of the sum functions output to r13.

;=========== Show number of values in array ============ 
mov qword rdi, stringNumFormat
mov qword rsi, r14                      ; Passes number of elements in the array to print.
mov qword rdx, r13                      ; Passes the sum of integers in the array to print.
mov qword rax, 0
call printf                             ; Prints out # of elements & sum

;=========== prints prompt for the sum of integers ================
mov qword rdi, stringFormat
mov qword rsi, sumprompt        
mov qword rax, 0
call printf                             ; Prints out that sum will be returned to main.

;=========== Pops ===========
; Restores all registers to their original state.
pop rax                                 ; Remove extra push of -1 from stack.
mov qword rax, r13                      ; Copies Sum (r13) to rax.
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
;=========== Return ==========

ret
