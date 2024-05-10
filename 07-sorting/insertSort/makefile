all: main

main.o: main.asm insertSort.asm ./include/printIntArr.asm ./include/printInt.asm
	nasm -f elf64 main.asm -o main.o

insertSort.o: insertSort.asm
	nasm -f elf64 insertSort.asm -o insertSort.o

./include/printIntArr.o: ./include/printIntArr.asm ./include/printInt.asm
	nasm -f elf64 ./include/printIntArr.asm -o ./include/printIntArr.o

./include/printInt.o: ./include/printInt.asm
	nasm -f elf64 ./include/printInt.asm -o ./include/printInt.o

main: main.o insertSort.o ./include/printIntArr.o ./include/printInt.o
	gcc -g -no-pie -o main main.o insertSort.o ./include/printIntArr.o ./include/printInt.o -lc

clean:
	rm -f main main.o insertSort.o ./include/printInt.o ./include/printIntArr.o
