all: main

main.o: main.asm printIntArr.asm ./include/printInt.asm
	nasm -f elf64 main.asm -o main.o

printIntArr.o: printIntArr.asm ./include/printInt.asm
	nasm -f elf64 printIntArr.asm -o printIntArr.o

./include/printInt.o: ./include/printInt.asm
	nasm -f elf64 ./include/printInt.asm -o ./include/printInt.o

main: main.o printIntArr.o ./include/printInt.o
	gcc -g -no-pie -o main main.o printIntArr.o ./include/printInt.o -lc

clean:
	rm -f main main.o printIntArr.o ./include/printInt.o
