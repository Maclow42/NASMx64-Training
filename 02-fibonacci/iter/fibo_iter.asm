; -----------------------------------------------------------------------------
; A 64-bit Linux application that writes the first 90 Fibonacci numbers. To
; assemble and run:
;
;     nasm -g -felf64 fibo_iter.asm && gcc -g -no-pie -o fibo_iter fibo_iter.o -lc && ./fibo_iter
; -----------------------------------------------------------------------------

        global  main
        global  fibo
        extern  printf
        
section .data
n   dw  10

section .text

print:
	; We need to call printf, but we are using rax, rbx, and rcx.  printf
	; may destroy rax and rcx so we will save these before the call and
	; restore them afterwards.

	push    rax                     ; caller-save register
	push    rcx                     ; caller-save register
	push    rdi                     ; caller-save register

	mov     rsi, rdi                ; set 2nd parameter (current_number)
	mov     rdi, format             ; set 1st parameter (format)
	xor     rax, rax                ; because printf is varargs

	; Stack is already aligned because we pushed three 8 byte registers
	call    printf                  ; printf(format, current_number)

	pop     rdi                     ; restore caller-save register
	pop     rcx                     ; restore caller-save register
	pop     rax                     ; restore caller-save register

	ret                             ; return to caller
format:
	db  "%li", 10, 0

main:
	push    rbp
	mov     rbp, rsp

	push	rdi
	push	rcx

	mov		rcx, [n]	 			; loop counter
	.loop:
		mov     rdi, rcx                ; set 1st parameter (current_number)
		call    fibo                    ; call fibo(current_number)

		mov	 	rdi, rax                ; set 1st parameter (current_number)
		call    print                   ; call print(current_number)

		loop 	.loop

	pop		rcx
	pop		rdi
	
	pop     rbp
	ret

fibo:
	push	rbx
	push	rcx

	mov 	rcx, rdi		; rcx = loop counter using argument (rdi)

	cmp 	rcx, 1			; if rcx < 2
	jle 	.base_case		; return rdi

	mov 	rbx, 0			; rbx = 0
	mov 	rax, 1			; rax = 1

	.loop:
		mov 	rdx, rax	; save rax
		add		rax, rbx	; rax = rax + rbx
		mov 	rbx, rdx	; rbx = rcx
		loop 	.loop
	.endloop:
		jmp 	.done

	.base_case:
		mov 	rax, rcx
		jmp 	.done

	.done:
		pop rcx
		pop rbx
		ret

	


