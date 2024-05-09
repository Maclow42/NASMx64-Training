; ----------------------------------------------------------------------------
; An implementation of the insertion sort algorithm in x86-64 assembly language.
; 
; The C code for the algorithm is:
;
; void insertionSort(int arr[], int n) {
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
;
; Compile and run with:
; nasm -g -felf64 insertSort.asm && gcc -g -no-pie -o insertSort insertSort.o callInsertSort.c -lc && ./insertSort
;
; ----------------------------------------------------------------------------

        global  main
        extern printf
        extern putchar

        section .data
list    dd      5, 2, 4, 6, 1, 3
size    dd      6

    int_format db "%d", 0    ; Format de sortie pour un entier
    newline db 10             ; Caractère de nouvelle ligne

        section .text


; int main() {
;     int arr[] = {5, 2, 4, 6, 1, 3};
;     int n = sizeof(arr) / sizeof(arr[0]);
;     insertionSort(arr, n);
;     return 0;
; }

main:
        push    rbp
        mov     rbp, rsp
        push    rbx

        mov     rdi, 1  ; Passer l'adresse du tableau
        call    printInt
        
        ;call    insertSort

        mov     eax, 0

        pop     rbx
        pop     rbp
        
        ret
        
printInt:
    push rbp
    mov rbp, rsp

    ; Sauvegarder les registres utilisés
    push rbx
    push rdi
    push rsi
    push rdx

    ; Mettre l'entier dans le format de chaîne de caractères
    mov rsi, rdi           ; Second argument: l'entier en paramètre
    mov rdi, int_format    ; Premier argument: format de chaîne pour printf
    xor rax, rax
    call printf            ; Appeler printf pour imprimer l'entier

    ; Imprimer un saut de ligne
    mov rdi, newline       ; Premier argument: caractère de nouvelle ligne
    call putchar           ; Appeler putchar pour imprimer le saut de ligne

    ; Restaurer les registres et retourner
    pop rdx
    pop rsi
    pop rdi
    pop rbx
    leave
    ret

; void insertionSort(int arr[], int n)
; arr is in rdi, n is in rsi
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
        