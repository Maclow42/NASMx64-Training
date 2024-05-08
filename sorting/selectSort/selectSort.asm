; ----------------------------------------------------------------------------
; An implementation of the selecting sort algorithm in x86-64 assembly language.
; 
; The C code for the algorithm is:
;
; void selectSort(int arr[], int n) {
;     int i, j, minIndex, tmp;
;     for (i = 0; i < n - 1; i++) {
;         minIndex = i;
;         for (j = i + 1; j < n; j++)
;             if (arr[j] < arr[minIndex])
;                 minIndex = j;
;         if (minIndex != i) {
;             tmp = arr[i];
;             arr[i] = arr[minIndex];
;             arr[minIndex] = tmp;
;         }
;     }
; }
;
; Compile and run with:
; nasm -g -felf64 selectSort.asm && gcc -g -no-pie -o selectSort selectSort.o callSelectSort.c -lc && ./selectSort
;
; ----------------------------------------------------------------------------

        global  selectSort

        section .text

selectSort:
.prologue:
        push    rbp
        mov     rbp, rsp        ; save the base pointer
        push    rbx             ; save the base register

        push    r12             ; save the registers
        push    r13

        mov     r12, rdi        ; rdi is the address of the array
        mov     r13, rsi        ; rsi is the number of elements in the array

        ; Init variables
        mov     r8, 0           ; i = 0
        mov     r9, 0           ; j = 0
        mov     r10, 0          ; minIndex = 0
        mov     r11, 0          ; tmp = 0

.mainLoop:
        cmp     r8, r13         ; while i < n
        jae     .done           ; if i >= n, go to done

        mov     r10, r8         ; minIndex = i

        mov     r9, r8          ; j = i

        .innerLoop:
                cmp     r9, r13                 ; while j < n
                jae     .mainLoopDone

                mov     eax, DWORD [r12 + r9 * 4]     ; rax = arr[j]
                cmp     eax, DWORD [r12 + r10 * 4]    ; arr[j] < arr[minIndex]
                jge     .innerLoopDone          ; if not, go to innerLoopDone

                mov     r10, r9                 ; minIndex = j

                jmp     .innerLoopDone

        .innerLoopDone:
                inc     r9                      ; j++
                jmp     .innerLoop              ; go to innerLoop


.mainLoopDone:
        cmp     r10, r8                 ; minIndex != i
        je      .mainLoopIncr           ; if minIndex == i, go to mainLoop

        mov     r11d, DWORD [r12 + r8 * 4]     ; tmp = arr[i]
        mov     eax, DWORD [r12 + r10 * 4]     ; rax = arr[minIndex]
        mov     DWORD [r12 + r8 * 4], eax      ; arr[i] = arr[minIndex]
        mov     DWORD [r12 + r10 * 4], r11d    ; arr[minIndex] = tmp

.mainLoopIncr:
        inc     r8                      ; i++
        jmp     .mainLoop               ; go to mainLoop


.done:
        pop     r13             ; restore the registers
        pop     r12

        pop     rbx             ; restore the base register
        pop     rbp             ; restore the base pointer
        ret
        