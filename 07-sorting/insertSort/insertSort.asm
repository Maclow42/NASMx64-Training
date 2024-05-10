; ----------------------------------------------------------------------------
; An implementation of the insertion sort algorithm in x86-64 assembly language.
; 
; The C code for the algorithm is:
;
; void insertSort(int arr[], int n) {
;     int i, j, key;
;     for (i = 1; i < n; i++) {
;         key = arr[i];
;         j = i - 1;
;         while (j >= 0 && arr[j] > key) {
;             arr[j + 1] = arr[j];
;             j = j - 1;
;         }
;         arr[j + 1] = key;
;     }
; }
; ----------------------------------------------------------------------------
        
        global insertSort

        section .text
    

; void insertSort(int arr[], int n)
; rdi = arr address
; rsi = n
insertSort:
.prologue:
        push    rbp
        mov     rbp, rsp        ; save the base pointer
        push    rbx             ; save the base register

        push    r8              ; save the registers
        push    r9
        push    r10
        push    r11             
        push    r12

        mov     r11, rdi        ; rdi is the address of the array
        mov     r12, rsi        ; rsi is the number of elements in the array

        ; Init variables
        mov     r8, 1           ; i = 0
        mov     r9, 0           ; j = 0
        mov     r10, 0         ; key = 0

.mainLoop:
        cmp     r8, r12                         ; while i < n
        jae     .done                           ; if i >= n, go to done

        mov     r10d, DWORD [r11 + r8 * 4]      ; key = arr[i]

        mov     r9, r8                        ; j = i
        dec     r9                            ; j = i - 1

        .innerLoop:
                cmp     r9, 0                   ; while j >= 0
                jl      .mainLoopDone           ; if j < 0, go to mainLoopDone

                mov     eax, DWORD [r11 + r9 * 4]     ; eax = arr[j]
                cmp     eax, r10d                     ; while arr[j] > key
                jle     .mainLoopDone                 ; if arr[j] <= key, go to mainLoopDone

                mov     DWORD [r11 + (r9+1) * 4], eax   ; arr[j+1] arr[j]
                sub     r9, 1                           ; j--

        .innerLoopDone:
                jmp     .innerLoop              ; go to innerLoop


.mainLoopDone:
        mov     DWORD [r11 + (r9+1) * 4], r10d  ; arr[j+1] = key
        inc     r8                              ; i++
        jmp     .mainLoop                       ; go to mainLoop

.done:            
        pop     r12     ; restore the registers
        pop     r11
        pop     r10
        pop     r9
        pop     r8

        pop     rbx             ; restore the base register
        pop     rbp             ; restore the base pointer
        ret
        