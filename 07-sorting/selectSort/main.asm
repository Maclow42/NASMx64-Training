; -----------------------------------------------------------------------------
; A 64-bit Linux application that prints an integer array to stdout
; To assemble and run:
;
; nasm -g -felf64 main.asm && gcc -g -no-pie -o main main.o -lc && ./main
; -----------------------------------------------------------------------------

extern print
extern printIntArr
extern selectSort

section .data
    newline db 10
    sys_exit equ 60

    arr1 dd 11, 2, 7, 6, 5, 4, 3, 8, 9, 10
    arr1.len equ 10

    beforeText db "Before sorting: ", 0
    beforeText.len equ $ - beforeText

    afterText db "After sorting: ", 0
    afterText.len equ $ - afterText

section .text

global main

main:
    ; Write the "Before sorting" text to stdout
    mov rdi, beforeText
    mov rsi, beforeText.len
    call print

    ; Write the newline character to stdout
    mov rdi, newline
    mov rsi,1
    call print

    ; Print the first array
    mov rdi, arr1
    mov rsi, arr1.len
    call printIntArr

    ; Write the newline character to stdout
    mov rdi,newline
    mov rsi,1
    call print

    ; Sort it
    mov rdi, arr1
    mov rsi, arr1.len
    call selectSort

    ; Write the "after sorting" text to stdout
    mov rdi, afterText
    mov rsi, afterText.len
    call print

    ; Write the newline character to stdout
    mov rdi, newline
    mov rsi,1
    call print

    ; Print the sorted version
    mov rdi, arr1
    mov rsi, arr1.len
    call printIntArr

    ; Write the newline character to stdout
    mov rdi, newline
    mov rsi,1
    call print

   ; Exit
    mov rax,sys_exit
    xor rdi, rdi  ; Paramètre status (ici, 0 pour indiquer une terminaison normale)
    syscall
