all: main

main.o: main.asm selectSort.asm ./include/printIntArr.asm ./include/printInt.asm
	nasm -f elf64 main.asm -o main.o

selectSort.o: selectSort.asm
	nasm -f elf64 selectSort.asm -o selectSort.o

./include/printIntArr.o: ./include/printIntArr.asm ./include/printInt.asm
	nasm -f elf64 ./include/printIntArr.asm -o ./include/printIntArr.o

./include/printInt.o: ./include/printInt.asm
	nasm -f elf64 ./include/printInt.asm -o ./include/printInt.o

main: main.o selectSort.o ./include/printIntArr.o ./include/printInt.o
	gcc -g -no-pie -o main main.o selectSort.o ./include/printIntArr.o ./include/printInt.o -lc

clean:
	rm -f main main.o selectSort.o ./include/printInt.o ./include/printIntArr.o
