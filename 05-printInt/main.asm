; -----------------------------------------------------------------------------
; A 64-bit Linux application that prints an integer to stdout
; To assemble and run:
;
; nasm -g -felf64 main.asm && gcc -g -no-pie -o main main.o printInt.o -lc && ./main
; -----------------------------------------------------------------------------

    section .data
    number dd 42	    ; The number to print
    newline db 10       ; The newline character
    sys_exit equ 60     ; The system call number for exit


    section .text
extern print
extern printInt

global main

main:
    mov edi, DWORD [number]            ; Move the number into rax
    call printInt               ; Print the number

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print
    
    ; Exit
    mov rax,sys_exit
    xor rdi, rdi  ; Paramètre status (ici, 0 pour indiquer une terminaison normale)
    syscall

