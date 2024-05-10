; -----------------------------------------------------------------------------
; A 64-bit Linux application that sort an integer array ussing insertion sort
; To assemble and run:
;
; nasm -g -felf64 main.asm && gcc -g -no-pie -o main main.o -lc && ./main
; -----------------------------------------------------------------------------

%include "../../06-printIntArr/printIntArr.asm"
%include "./insertSort.asm"

section .data
    arr1 dd 42, 11, 23, 13
    arr1.len equ 4

    arr2 dd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    arr2.len equ 10

section .text

global main

main:
    ; Print the first array
    mov rdi, arr1
    mov rsi, arr1.len
    call printIntArr

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print

    ; Print the second array
    mov rdi, arr2
    mov rsi, arr2.len
    call printIntArr

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print
    
   ; Exit
    mov rax,sys_exit
    mov rbx,0

    int 0x80
