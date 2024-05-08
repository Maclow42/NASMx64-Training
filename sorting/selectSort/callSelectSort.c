/*
 * An application that illustrates calling the factorial function defined elsewhere.
 */

#include <stdio.h>
#include <inttypes.h>

int selectSort(int n[], int size);

void printArray(int n[], int size){
    for (int i = 0; i < size; i++) {
        printf("%i ", n[i]);
    }
    printf("\n");
}

int main() {
    int n[] = {5, 2, 4, 6, 1, 3};
    int size = sizeof(n) / sizeof(n[0]);

    printf("Before sorting: ");
    printArray(n, size);

    selectSort(n, size);

    printf("After sorting: ");
    printArray(n, size);

    return 0;
}