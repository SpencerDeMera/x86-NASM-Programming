;****************************************************************************************************************************
;Program name: "Circumference of Circle".  This programs accepts a non-negative integer from the user and     *
;then outputs the circumference of a cirlce.                                                           *
;Copyright (C) 2020  Spencer DeMera                                                                                        *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;Author: Spencer DeMera
;Course ID: CPSC 240-05
;Assignment Number: 1
;Due Date: 09/10/2020
;Purpose: Homework && Extra Credit

;Declare the names of programs called from this X86 source file, but whose own source code is not in this file.
extern printf                                     ;Reference: Jorgensen book 1.1.40, page48
extern scanf

;Declare constants if needed
null equ 0                                        ;Reference: Jorgensen book 1.1.40, page 34.
newline equ 10

global circle                                 ;Make this program callable by other programs.

segment .data                                     ;Initialized data are placed in this segment

;main messages
welcome db "The circle function is brought to you by Spencer.", newline, null
promptforinteger1 db "Please enter the radius of a circle in whole number of meters : ", null
outputformat1 db "The number %ld was received.", 10, 0
stringoutputformat db "%s", 0
signedintegerinputformat db "%ld", null

;circumference output
outputformat3 db "The circumference of a circle with this radius is %ld and %d meters.", 10 , 0

;farewell message
farewell db "The integer part of the area will be returned to the main program.  Please enjoy your circles.", 10, 0

segment .bss                                      ;Uninitialized data are declared in this segment

segment .text                                     ;Instructions are placed in this segment
circle:                                       ;Entry point for execution of this program.

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Output the welcome message                       ;This is a group of instructions jointly performing one task.
mov qword rdi, stringoutputformat
mov qword rsi, welcome
mov qword rax, 0
call printf

;Prompt for the first integer
mov qword rdi, stringoutputformat
mov qword rsi, promptforinteger1                  ;Place the address of the prompt into rdi
mov qword rax, 0
call printf

;Input the first integer
mov qword rdi, signedintegerinputformat
push qword -1                                     ;Place an arbitrary value on the stack; -1 is ok, any quad value will work
mov qword rsi, rsp                                ;Now rsi points to that dummy value on the stack
mov qword rax, 0                                  ;No vector registers
call scanf                                        ;Call the external function; the new value is placed into the location that rsi points to
pop qword r14                                     ;First inputted integer is saved in r14

;Output the value previously entered
mov qword rdi, outputformat1
mov rsi, r14
mov qword rdx, r14                                ;Both rsi and rdx hold the inputted value as well as r14
mov qword rax, 0
call printf

;calculations
mov qword r15, 22				  ;r15 = 22
mov qword r8, 7					  ;r8 = 7
mov qword r9, 2					  ;r9 = 2
mov qword rax, r14                                ;Copy the first factor (operand) to rax
mov qword rdx, 0                                  ;rdx contains no data we wish to save.
mul r9						  ;rax -> radius * 2
mul r15                                           ;rax -> (2 * radius) * 22

;rax already holds (2 * radius) * 22
div r8						  ;rax -> ((2* radius) * 22) / 7
push rax					  ;pushes rax 

;show circumference
mov qword rdi, outputformat3
mov qword rsi, rax				  ;moves rax into rsi
mov qword rdx, rdx				  ;moves rdx back into rdx
mov qword rax, 0
call printf	

;Output the farewell message
mov qword rdi, stringoutputformat
mov qword rsi, farewell                           ;The starting address of the string is placed into the second parameter.
mov qword rax, 0
call printf

;Restore the original values to the general registers before returning to the caller.
pop rax                                                     ;idk bruh
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret                                          ;Pop the integer stack and jump to the address represented by the popped value.
