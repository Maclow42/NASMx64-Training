; -----------------------------------------------------------------------------
; A 64-bit Linux application that prints an integer array to stdout
; To assemble and run:
;
; nasm -g -felf64 main.asm && gcc -g -no-pie -o main main.o -lc && ./main
; -----------------------------------------------------------------------------

%include "./printIntArr.asm"

section .data
    intArr dd 42, 11, 23, 13	    ; The number to print
    intArr.len equ 4

section .text

global main

main:
    mov rdi, intArr
    mov rsi, intArr.len
    call printIntArr

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print
    
   ; Exit
    mov rax,sys_exit
    mov rbx,0

    int 0x80
