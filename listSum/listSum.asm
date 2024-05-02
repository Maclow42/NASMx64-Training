; -----------------------------------------------------------------------------
; A 64-bit Linux application that writes the sum of all the list elements
; assemble and run:
;
;     nasm -g -felf64 listSum.asm && gcc -g -no-pie -o listSum listSum.o -lc && ./listSum
; -----------------------------------------------------------------------------

        global  main
        extern  printf
        
section .data
list    dd      1, 2, 3, 4, 5, 6, 7, 8, 9, 10
len     dd      10
sum     dq      0 

section .text

print:
        ; We need to call printf, but we are using rax, rbx, and rcx.  printf
        ; may destroy rax and rcx so we will save these before the call and
        ; restore them afterwards.

        push    rax                     ; caller-save register
        push    rcx                     ; caller-save register
        push    rdi                     ; caller-save register
        push    rsi                     ; caller-save register

        mov     rsi, rdi                ; set 2nd parameter (current_number)
        mov     rdi, format             ; set 1st parameter (format)
        xor     rax, rax                ; because printf is varargs

        ; Stack is already aligned because we pushed three 8 byte registers
        call    printf                  ; printf(format, current_number)

        pop     rsi                     ; restore caller-save register
        pop     rdi                     ; restore caller-save register
        pop     rcx                     ; restore caller-save register
        pop     rax                     ; restore caller-save register

        ret                             ; return to caller
        
format:
        db  "%li", 10, 0

main:
    mov rbp, rsp; for correct debugging
    push rcx
    push rbx
    
    mov     ecx, dword [len]                            ; i
    .sumLoop:
        mov     eax, dword [list + (ecx-1) * 4]         ; Charger la valeur de list[i] dans eax
        add     qword [sum], rax                        ; Ajouter la valeur chargée à la somme
        loop    .sumLoop

        
    mov rdi, qword [sum]
    call print
    
end:
    pop rbx
    pop rcx

    mov rax, 0                 ; exit code SUCCESS
    ret
    

        