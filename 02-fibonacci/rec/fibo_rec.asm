; -----------------------------------------------------------------------------
; A 64-bit Linux application that writes the first 90 Fibonacci numbers. To
; assemble and run:
;
;     nasm -g -felf64 fibo_rec.asm && gcc -g -no-pie -o fibo_rec fibo_rec.o -lc && ./fibo_rec
; -----------------------------------------------------------------------------

        global  main
        extern  printf

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
        push    rbx                     ; we have to save this since we use it
        push    rdi                     ; we have to save this since we use it
        push    rsi                     ; we have to save this since we use it

        mov     rdi, 0                  ; initialize i to 0
        .loop:
                cmp     rdi, 10                ; compare i with [rsi]
                jg      .end_loop                ; jump to end_loop if i > [rsi]
                push    rdi                     ; save i on the stack

                call    fibo                    ; call fibo(i)

                mov     rdi, rax                ; set 1st parameter (current_number)
                call    print                   ; print result
                pop     rdi                     ; restore i from the stack
                inc     rdi                     ; increment i by 1
                jmp     .loop                    ; jump back to loop

        .end_loop:
                pop     rsi                     ; restore rsi
                pop     rdi                     ; restore rdi
                pop     rbx                     ; restore rbx
                

fibo:
        ; rdi = n

        push    rdi                     ; caller-save register
        push    rbx                     ; callee-save register

        ; if n <= 1, return n
        cmp     rdi, 1
        jle     .basis_case

        ; n > 1
        dec    rdi                     ; n = n - 1
        call   fibo                    ; fib(n - 1)
        mov    rbx, rax                ; save result in rbx

        dec    rdi                     ; n = n - 2
        call   fibo                    ; fib(n - 2)
        add    rax, rbx                ; return fib(n - 1) + fib(n - 2)
        jmp    .end

        .basis_case:
                mov    rax, rdi
                jmp    .end

        .end:
                pop    rbx                     ; restore callee-save register
                pop    rdi                     ; restore caller-save register
                ret
