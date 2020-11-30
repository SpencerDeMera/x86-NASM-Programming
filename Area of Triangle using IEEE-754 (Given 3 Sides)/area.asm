; ****************************************************************************************************************************
; Program name: "Area of Triangle with IEEE754". This program takes 3 userinputs for lengths of the sides of triangle,      	*
; calculates the area of said triangle, and prints it. Copyright (C) 2020  Spencer DeMera                                             					*     
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
;  Date program began: 11-22-2020
;  Date of last update: 11-24-2020
;  Comments reorganized: 11-24-2020
;  Files in the program: triangle.c, area.asm, isfloat.cpp, run.sh

; Purpose
;  Compute the area of a triangle given userinput.
;  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

; This file
;  File name: area.asm
;  Language: x86 NASM
;  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
;  Compile: nasm -f elf64 -l area.lis -o area.o area.asm
;  Link: gcc -m64 -no-pie -o area.out -std=c11 area.o isfloat.o atof.o triangle.o 

; Execution: ./area.out

; ============ Begin code area ============
extern printf                   ; external C++ printf file
extern scanf                    ; external C++ scanf file
extern atof                     ; external C++ atof file
extern isfloat                  ; external C++ isfloat file
null equ 0
newline equ 10

arraySize equ 3

global area

;============ Declare some messages ============
section .data                                     ;Initialized data are placed in this segment
    sidesprompt db "Enter the floating point lengths of the 3 sides of your Triangle : ", 10, 10, 0
        side1 db "  Side 1: ", 0
        side2 db "  Side 2: ", 0
        side3 db "  Side 3: ", 0
    outputvalues db 10, "These values were recieved : ", 0
    invalidinput db 10, "An invalid input was detected. Please run the program again.", 10, 10, 0
    triArea db 10, 10, "The area of this triangle is %lf square meters", 10, 0
    floats db "%lf ", 0
    stringoutputformat db "%s", 0        ;general string format
    floatinputformat db "%lf", 0         ;general float format

section .bss                             ;Uninitialized data are declared in this segment
    array: resq 3                        ;Declare a static array for demonstration purposes

section .text                            ;Instructions are placed in this segment

area:                                    ;Entry point for execution of this program.

;==============================================================================================================
;===== Begin the application here: show how to input and output floating point numbers ========================
;==============================================================================================================

;============ Pushes ============
push rbp                                 ;Backup rbp
mov  rbp, rsp                            ;The base pointer now points to top of stack
push rdi                                 ;Backup rdi
push rsi                                 ;Backup rsi
push rdx                                 ;Backup rdx
push rcx                                 ;Backup rcx
push r8                                  ;Backup r8
push r9                                  ;Backup r9
push r10                                 ;Backup r10
push r11                                 ;Backup r11
push r12                                 ;Backup r12
push r13                                 ;Backup r13
push r14                                 ;Backup r14
push rbx                                 ;Backup rbx

push qword -1                            ;Place an arbitrary value on the stack; -1 is ok, any quad value will work

mov r15, 0                              ;bool flag
mov r14, 0                              ;ctr for which side to print

;============ Show the initial messages ============
mov qword rdi, stringoutputformat
mov qword rsi, sidesprompt
mov qword rax, 0
call printf

;=================================================
;============ Input floats into array ============
;=================================================
mov qword r13, 0                        ;Set counter to 0 elements in Array
jmp beginloop

;============ Print invalid input message block ============
Errormssge:
mov qword rdi, stringoutputformat
mov qword rsi, invalidinput
mov qword rax, 0
pop r8
call printf                             ; Prints out received confirmation

beginloop:

;============ Input prints for each side ============
cmp r14, 0
je Side1Mssg                            ; if r14 == 0 jmp to side1 input
cmp r14, 1
je Side2Mssg                            ; if r14 == 1 jmp to side2 input
cmp r14, 2
je Side3Mssg                            ; if r14 == 2 jmp to side3 input

Side1Mssg:
mov qword rdi, stringoutputformat
mov qword rsi, side1
mov qword rax, 0
call printf
inc r14
jmp InputsBlock

Side2Mssg:
mov qword rdi, stringoutputformat
mov qword rsi, side2
mov qword rax, 0
call printf
inc r14
jmp InputsBlock

Side3Mssg:
mov qword rdi, stringoutputformat
mov qword rsi, side3
mov qword rax, 0
call printf
inc r14
jmp InputsBlock

InputsBlock:
;============ String Inputs ============
mov qword rdi, stringoutputformat
push qword 0
mov qword rsi, rsp                      ; Stack pointer points to where scanf outputs.
mov qword rax, 0
call scanf

;============ Call & check data block ============
mov qword rax, 0
mov qword rdi, rsp
call isfloat
cmp rax, 0                              ; Checks to see if isfloat returned true/false
je Errormssge                           ; If isfloat returns 0, jumpo to error output

;============ Call & Convert block ============
mov qword rax, 0
mov qword rdi, rsp
call atof                               ; returns floats into xmm0
movsd xmm10, xmm0                       ; Moves xmm0 into xmm10
pop r8

;============ Adds elements to the array ============
movsd [array + 8 * r13], xmm10          ; Copies user input into array at index of r13.
inc r13                                 ; Increments counter r13 by 1.

;============ Compare Block ============
cmp r13, arraySize                      ; Compares # of elements (r13) to arraySize.
je exitloop                             ; If # of elements equals capacity, exit loop.

;============ Continue ============
; Restarts loop.
jmp beginloop

;============ Exit block ============
exitloop:
pop r8

;=================================================
;============ Floats now in the array ============
;=================================================

;============ Print float values block ============
mov qword rdi, stringoutputformat
mov qword rsi, outputvalues
mov qword rax, 0
call printf                             ; Prints out received confirmation
jmp printArr

;=================================================
;============ Print contents of array ============
;=================================================
printArr:

mov qword r13, 0                        ; Set counter to 0 elements in array

begin2loop:

;============ Print float array elements ============
movsd xmm0, [array + 8 * r13]
mov rdi, floats                         ; prints element at index 
mov rax, 1
call printf

inc r13                                 ; incremenets r13++

;============ Compare Block ============
cmp r13, arraySize                      ; Compares # of elements (r13) to arraySize
je endofloop                            ; If # of elements equals capacity, exit loop

;============ Continue ============
jmp begin2loop                          ; Restarts loop.

;============ Exit block ============
endofloop:

;=================================================
;============ Array contents printed ============
;=================================================

;============ Calculations Block ============
movsd xmm10, [array + 8 * 0]
movsd xmm11, [array + 8 * 1]
movsd xmm12, [array + 8 * 2]

mov rax, 0x4000000000000000         ;2.0 in hex
push rax
movsd xmm13, [rsp]                  ; mov 2.0 -> xmm13
pop rax

addsd xmm10, xmm11                  ; xmm10(side1) + xmm11(side2) -> xmm10
addsd xmm10, xmm12                  ; xmm10(side1 + side2) + xmm12(side3) -> xmm10(length)
divsd xmm10, xmm13                  ; xmm10(length) / xmm13(2) -> xmm10(s)

movsd xmm11, [array + 8 * 0]
movsd xmm12, [array + 8 * 1]
movsd xmm13, [array + 8 * 2]

movsd xmm14, xmm10                  ; copy xmm10(s) into xmm14
subsd xmm14, xmm11                  ; xmm14(s) - xmm11(side1) -> xmm14

movsd xmm15, xmm10                  ; copy xmm10(s) into xmm15
subsd xmm15, xmm12                  ; xmm15(s) - xmm12(side2) -> xmm15

movsd xmm11, xmm10                  ; copy xmm10(s) into xmm15
subsd xmm11, xmm13                  ; xmm11(s) - xmm12(side3) -> xmm11

mulsd xmm10, xmm14                  ; xmm10(s) * xmm14(s - side1) -> xmm10
mulsd xmm10, xmm15                  ; xmm10 * xmm15(s - side2) -> xmm10
mulsd xmm10, xmm11                  ; xmm10 * xmm11(s - side3) -> xmm10

sqrtsd xmm10, xmm10                 ; sqrt(s(s-side1)(s-side2)(s-side3)) -> xmm10 

;============ Show area ============
mov rax, 1
mov rdi, triArea
movsd xmm0, xmm10
call printf	

;============ Pops ============
movsd xmm0, xmm10                       ;xmm10 -> xmm0 = mov into rax
pop rax                                 ;idk bruh
pop rbx                                 ;Restore rbx
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

;============ Return ============
ret                                     ;Pop the integer stack and jump to the address represented by the popped value.
