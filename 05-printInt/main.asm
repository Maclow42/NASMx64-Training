; -----------------------------------------------------------------------------
; A 64-bit Linux application that prints an integer to stdout
; To assemble and run:
;
; nasm -g -felf64 main.asm && gcc -g -no-pie -o main main.o -lc && ./main
; -----------------------------------------------------------------------------

%include "./printInt.asm"

section .data
    number dd 42	    ; The number to print

section .text

global main

main:
    mov rdi,[number]            ; Move the number into rax
    call printInt               ; Print the number

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print
    
   ; Exit
    mov rax,sys_exit
    mov rbx,0

    int 0x80