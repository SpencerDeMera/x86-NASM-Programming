; ****************************************************************************************************************************
; Program name: "Circumference of Circle with Pi". This program takes an array of integers, swaps them, sorts them,      	*
;  and prints the array. Copyright (C) 2020  Spencer DeMera                                             					*                                                                             *
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
;  Program name: circumference with pi
;  Programming languages: C++. X86, C.
;  Date program began: 10-28-2020
;  Date of last update: 11-9-2020
;  Comments reorganized: 11-9-2020
;  Files in the program: main.c, manager.asm, displayArray.cpp, sum.asm, inputArray.asm, run.sh

; Purpose
;  Compute the Sum of Integers and Print them as an Array.
;  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

; This file
;  File name: circle.asm
;  Language: x86
;  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
;  Compile: nasm -f elf64 -l circle.lis -o circle.o circle.asm
;  Link: gcc -m64 -no-pie -o arrays.out -std=c11 manager.o inputArray.o sum.o displayArray.o main.o 

; Execution: ./arrays.out

;============ Begin code area ============
extern printf                                               ;External C++ function for writing to standard output device
extern scanf                                                ;External C++ function for reading from the standard input device

null equ 0
newline equ 10

global circle                                 ;Make this program callable by other programs.

;============ Declare some messages ============
section .data                                     ;Initialized data are placed in this segment
    welcome db "The circle function is brought to you by Spencer DeMera.", 10, 0
    promptforinteger1 db "Please enter the radius of a circle as a floating point number : ", 0
    outputformat1 db 10, "The number %lf was received.", 10, 10, 0
    outputformat3 db "The circumference of a circle with this radius is %lf meters.", 10 , 0
    farewell db "The integer part of the area will be returned to the main program.  Please enjoy your circles.", 10, 0
    stringoutputformat db "%s", 0                   ;general string format
    floatinputformat db "%lf", 0                    ;general float format

section .bss                                        ;Uninitialized data are declared in this segment

section .text                                       ;Instructions are placed in this segment

circle:                                             ;Entry point for execution of this program.

;==============================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ========================
;==============================================================================================================

;============ Pushes ============
push rbp                                          ;Backup rbp
mov  rbp, rsp                                     ;The base pointer now points to top of stack
push rdi                                          ;Backup rdi
push rsi                                          ;Backup rsi
push rdx                                          ;Backup rdx
push rcx                                          ;Backup rcx
push r8                                           ;Backup r8
push r9                                           ;Backup r9
push r10                                          ;Backup r10
push r11                                          ;Backup r11
push r12                                          ;Backup r12
push r13                                          ;Backup r13
push r14                                          ;Backup r14
push rbx                                          ;Backup rbx
pushf                                             ;Backup rflags

push qword -1                                     ;Place an arbitrary value on the stack; -1 is ok, any quad value will work

;============ Show the initial message ============
mov qword rdi, stringoutputformat
mov qword rsi, welcome
mov qword rax, 0
call printf

;============ Prompt user for input ============
mov qword rdi, stringoutputformat
mov qword rsi, promptforinteger1                  ;Place the address of the prompt into rdi
mov qword rax, 0
call printf

;============ Input first integer ============
mov qword rax, 0                                  ;No vector registers
mov qword rdi, floatinputformat
mov qword rsi, rsp                                ;Now rsi points to that dummy value on the stack
call scanf                                        ;Call the external function; the new value is placed into the location that rsi points to
movsd xmm10, [rsp]                                ;copy of radius -> xmm10

;============ Output previously entered values ============
movsd xmm0, xmm10
mov rdi, outputformat1
mov rax, 1
call printf

;============ Calculations Block ============
mov rax, 0x4000000000000000         ;2.0 in hex
push rax
movsd xmm12, [rsp]                  ;mov 2.0 -> xmm12
pop rax

mov rax, 0x400921FB54442D18         ;pi in hex
push rax
movsd xmm13, [rsp]                  ;mov pi -> xmm13
pop rax

mulsd xmm10, xmm12                   ;radius * 2.0 -> xmm10
mulsd xmm10, xmm13                   ;xmm10 * pi = C -> xmm10

;============ Show circumference ============
movsd xmm0, xmm10
mov rdi, outputformat3
mov rax, 1
call printf	

;============ Farwell message ============
mov qword rdi, stringoutputformat
mov qword rsi, farewell                           ;The starting address of the string is placed into the second parameter.
mov qword rax, 0
call printf

;============ Pops ============
pop rax                                            ;idk bruh
popf                                               ;Restore rflags
pop rbx                                            ;Restore rbx
pop r14                                            ;Restore r14
pop r13                                            ;Restore r13
pop r12                                            ;Restore r12
pop r11                                            ;Restore r11
pop r10                                            ;Restore r10
pop r9                                             ;Restore r9
pop r8                                             ;Restore r8
pop rcx                                            ;Restore rcx
pop rdx                                            ;Restore rdx
pop rsi                                            ;Restore rsi
pop rdi                                            ;Restore rdi
pop rbp                                            ;Restore rbp

;============ Return ============
movsd xmm0, xmm10                             ;xmm9 -> xmm0 = mov into rax
ret                                          ;Pop the integer stack and jump to the address represented by the popped value.
