; ****************************************************************************************************************************
; Program name: "Final Exam". This program takes in user input to compute pay rates of a worker     	*
; Copyright (C) 2020  Spencer DeMera                                             					*     
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
;  Program name: Final Exam
;  Programming languages: C++. X86, C.
;  Date program began: 12-14-2020
;  Date of last update: 12-14-2020
;  Comments reorganized: 12-14-2020
;  Files in the program: grosspay.c, compute.asm, isfloat.cpp, run.sh

; Purpose
;  Compute the Pay of a worker
;  For learning purposes: Demonstrate use of hybrid programming concepts in a theoretical setting

; This file
;  File name: compute.asm
;  Language: x86 NASM
;  Optimal print specification: 7 point font, monospace, 136 columns, 8½x11 paper
;  Compile: nasm -f elf64 -l compute.lis -o compute.o compute.asm
;  Link: gcc -m64 -no-pie -o paycalc.out -std=c11 compute.o isfloat.o grosspay.o

; Execution: ./paycalc.out

; ============ Begin code area ============
extern printf                   ; external C++ printf file
extern scanf                    ; external C++ scanf file
extern atof                     ; external C++ atof file
extern isfloat                  ; external C++ isfloat file
null equ 0
newline equ 10

global pay

;============ Declare some messages ============
section .data                                     ;Initialized data are placed in this segment
    hoursprompt db "Please enter hours worked : ", 0
    payrateprompt db "Please enter pay rate : ", 0
    totalpay db "Total Pay : $%.2lf", 10, 0
    Errormssge db "Error please try again : ", 0
    stringoutputformat db "%s", 0        ;general string format
    floatinputformat db "%lf", 0         ;general float format

section .bss                             ;Uninitialized data are declared in this segment

section .text                            ;Instructions are placed in this segment

pay:                                     ;Entry point for execution of this program.

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

;=================================================
;============ Hours Worked Input Block ============
;=================================================
HoursLoop:                                  ; HoursLoop
;============ Show the initial messages ============
mov qword rdi, stringoutputformat
mov qword rsi, hoursprompt
mov qword rax, 0
call printf
jmp inputs1                                 ; skip over error message

;============ Error Message Block ============
Err1:
mov qword rdi, stringoutputformat
mov qword rsi, Errormssge
mov qword rax, 0
call printf
pop r8

inputs1:
;============ Input hours worked ============                   
mov qword rdi, stringoutputformat
push qword 0
mov qword rsi, rsp
mov qword rax, 0    
call scanf

;============ Call & check data block ============
mov qword rax, 0
mov qword rdi, rsp
call isfloat
cmp rax, 0
je Err1                                     ; if isfloat == false jmp to Err

;============ Call & Convert block ============
mov qword rax, 0
mov qword rdi, rsp
call atof                               ; returns floats into xmm0
movsd xmm10, xmm0                       ; Moves xmm0 into xmm10
pop r8

;=================================================
;============ Pay Rate Input Block ============
;=================================================
PayLoop:                                    ; PayLoop
;============ Show the initial messages ============
mov qword rdi, stringoutputformat
mov qword rsi, payrateprompt
mov qword rax, 0
call printf
jmp inputs2                                 ; skip over error message

;============ Error Message Block ============
Err2:
mov qword rdi, stringoutputformat
mov qword rsi, Errormssge
mov qword rax, 0
call printf
pop r8

inputs2:
;============ Input hours worked ============
mov qword rdi, stringoutputformat
push qword 0
mov qword rsi, rsp
mov qword rax, 0    
call scanf

;============ Call & check data block ============
mov qword rax, 0
mov qword rdi, rsp
call isfloat
cmp rax, 0
je Err2                                     ; if isfloat == false jmp to Err

;============ Call & Convert block ============
mov qword rax, 0
mov qword rdi, rsp
call atof                               ; returns floats into xmm0
movsd xmm11, xmm0                       ; Moves xmm0 into xmm11
pop r8

;=======================================
;============ Compute Block ============
;=======================================
mov r10, 0x4044000000000000                 ; copy 40.0 -> r10
push rax
movq xmm13, r10                             ; copy 40.0 -> xmm13

mov r11, 0x3fe0000000000000                 ; copy 0.5 -> r11
push rax
movq xmm12, r11                             ; copy 0.5 -> xmm12

;============ Gross Pay ============
movsd xmm14, xmm10                          ; copy xmm10 -> xmm14
mulsd xmm10, xmm11                          ; xmm10(hours) * xmm11(pay) -> xmm10

;============ Comparison Block ============
ucomisd xmm14, xmm13
ja calcOverTime                             ; if xmm10(hours) > xmm13(40) jmp calcOverTime
pop r8

;============ Finished (No Overtime) ============
mov rdi, totalpay
mov rax, 1
movsd xmm0, xmm10
call printf	

movsd xmm0, xmm10                           ; xmm10 -> xmm0 == mov into rax & ret
jmp exit

;============ Over Time ============
calcOverTime:
subsd xmm14, xmm13                          ; xmm14(hours) - xmm13(40) -> xmm14
mulsd xmm14, xmm12                          ; xmm14(overtime) * xmm12(0.5) -> xmm14
mulsd xmm14, xmm11                          ; xmm14(overtime * 0.5) * xmm11(pay) -> xmm14
addsd xmm14, xmm10                          ; xmm14(overtime) + xmm10(gross pay) -> xmm14

;============ Finished (w/ Overtime) ============
push qword 0
mov rdi, totalpay
mov rax, 1
movsd xmm0, xmm14
call printf	
pop r9

movsd xmm0, xmm14                           ; xmm14 -> xmm0 == mov into rax & ret
pop r9

;============ Exit Block ============
exit:

;============ Pops ============
pop rax
pop rax                                 ;Restore rax
pop rbx                                 ;Restore rbx
pop r14                                 ;Restore r14
pop r13                                 ;Restore r13
pop r12                                 ;Restore r12
pop r11                                 ;Restore r11
pop r10                                 ;Restore r10
pop r9                                  ;Restore r9
pop r8                                  ;Restore r8
pop rcx                                 ;Restore rcx
pop rdx                                 ;Restore rdx
pop rsi                                 ;Restore rsi
pop rdi                                 ;Restore rdi
pop rbp                                 ;Restore rbp

;============ Return ============
ret                                     ;Pop the integer stack and jump to the address represented by the popped value.
