section .data

    newline db 10

    ; int 0x80 information
    sys_exit equ 1
    sys_write equ 4

    ; Streams
    stdout equ 1

    ; Constants
    BUFFER_SIZE equ 10

section .bss

    numbuf resb BUFFER_SIZE	    ; A buffer to store our string of numbers in

section .text

; print a string to stdout
; rdi = string pointer
; rsi = string length
; returns nothing
print:
    push rax
    push rbx
    push rcx
    push rdx
    
    mov rax,sys_write
    mov rbx,stdout
    mov rcx,rdi
    mov rdx,rsi

    int 0x80

    pop rdx
    pop rcx
    pop rbx
    pop rax

    ret

; print a string to stdout
; rdi = int to print
; returns nothing
printInt:
    call itoa               ; result in rax, length in rcx

    mov rdi,rax             ; pointer to the string
    mov rsi,rcx             ; length of the string
    call print              ; print the string

    int 0x80

    ret

; itoa - convert a number to a string
; rdi = number
; returns a pointer to the string in rax and the length in rcx
itoa:

    push rbp		
    mov rbp,rsp
    sub rsp,4               ; allocate 4 bytes for our local string length counter

    mov rax,rdi	            ; Move the passed in argument to rax
    lea rdi,[numbuf+10]     ; load the end address of the buffer (past the very end)
    mov rcx,10	            ; divisor
    mov [rbp-4],dword 0	    ; rbp-4 will contain 4 bytes representing the length of the string - start at zero

.divloop:
    xor rdx,rdx             ; Zero out rdx (where our remainder goes after idiv)
    idiv rcx		        ; divide rax (the number) by 10 (the remainder is placed in rdx)
    add rdx,0x30	        ; add 0x30 to the remainder so we get the correct ASCII value
    dec rdi		            ; move the pointer backwards in the buffer
    mov byte [rdi],dl	    ; move the character into the buffer
    inc dword [rbp-4]	    ; increase the length
    
    cmp rax,0		        ; was the result zero?
    jnz .divloop	        ; no it wasn't, keep looping

    mov rax,rdi		        ; rdi now points to the beginning of the string - move it into rax
    mov rcx,[rbp-4]	        ; rbp-4 contains the length - move it into rcx

    leave		            ; clean up our stack
    ret