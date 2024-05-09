%include "../05-printInt/printInt.asm"

	section .data
comma		db 		", ", 0
comma.len 	equ 	$ - comma


	section .text

global printIntArr

; void printIntArr(int* arr, int len){
; 	for(int i = 0; i < len; i++){
; 		printInt(arr[i]);
;       print(", ");	
; 	}
; }
; rdi = arr address
; rsi = len
printIntArr:
.prologue:
	push r8
	push r9
	push r10

.body:
	mov	r8, rdi		; r8 = arr address
	mov r9, rsi		; r9 = len

	mov r10, 0		; r10 = i

	.loop:
		; for(int i = 0; i < len; i++)
		cmp r10, r9		; if len < i
		jae .epilogue	; if i >= len -> epilogue

		; printInt(arr[i])
		mov edi, DWORD [r8 + r10 * 4]	; rdi = arr[i]
		call printInt


		; print(", ")
		mov rdi, comma
		mov rsi, comma.len
		call print

		; i++
		inc r10
		jmp .loop


.epilogue:
	pop r10
	pop r9
	pop r8

	ret
