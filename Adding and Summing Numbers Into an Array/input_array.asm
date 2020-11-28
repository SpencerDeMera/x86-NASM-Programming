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
extern atolong
extern isinteger

global input_array                  ; Makes function callable from other linked files.

;===== Declare some messages ==============================================================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.  They are not variables.  They are not constants.  There are no constants in
;assembly programming.  There are no variables in assembly programming: the registers assume the role of variables.

section .data
    invalid db "The last input was invalid and not entered into the array.", 10, 0
    stringFormat db "%s", 0

section .bss

;==========================================================================================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ====================================================================================
;==========================================================================================================================================================================

section .text

input_array:

;============ Pushes ============
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

push qword -1                           ; Extra push to create even number of pushes

;============ Initialize values ============
mov qword r15, rdi                      ; Address of array saved to r15.
mov qword r14, rsi                      ; Max number of elements allowed in array.
mov qword r13, 0                        ; Set counter to 0 elements in Array.


;============ Begin loop block area ============
begin_loop:

; Scanf function called to take user input.
mov qword rdi, stringFormat
push qword 0
mov qword rsi, rsp                      ; Stack pointer points to where scanf outputs.
mov qword rax, 0
call scanf

; Tests if Control + D is entered to finish inputing into array.
cdqe
cmp rax, -1                          
je end_of_loop                          ; If control + D is entered, jump to end_of_loop.

;============ secondary input validation ============
mov qword rax, 0
mov qword rdi, rsp
call isinteger
cmp rax, 0                              ; Checks to see if isinteger returned true/false.
je invalid_input                        ; If isinteger returns 0. jump to not_an_int label.

;============ Conversion block ============
mov qword rax, 0
mov qword rdi, rsp
call atolong                            
mov qword r12, rax                      ; Saves output long integer from atolong in r12.
pop r8                                  ; Pop off stack into any scratch register. 

;============ Copy to array block ============
mov [r15 + 8 * r13], r12                ; Copies user input into array at index of r13.
inc r13                                 ; Increments counter r13 by 1.

;============ Integer Cap test block ============
cmp r13, r14                            ; Compares # of elements (r13) to capacity (r14).
je exit                                 ; If # of elements equals capacity, exit loop.

; Restarts loop.
jmp begin_loop

;============ Invalid input block & beginloop jump ============
invalid_input:
mov rdi, stringFormat
mov rsi, invalid 
mov rax, 0
call printf
pop r8                                 ; Pop off stack to any scratch register.  
jmp begin_loop                         ; Restarts loop.

;============ Endofloop block ============
end_of_loop:
pop r8                                  ; Pop off stack into any scratch register.                

;============ Exit block ============
exit:

;============ Pops ============
; Restore all backed up registers to their original state.
pop rax                                 ; Remove extra push of -1 from stack.
mov qword rax, r13                      ; Copies # of elements in r13 to rax.
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
