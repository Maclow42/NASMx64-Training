all: main

main.o: main.asm printInt.asm
	nasm -f elf64 main.asm -o main.o

printInt.o: printInt.asm
	nasm -f elf64 printInt.asm -o printInt.o

main: main.o printInt.o
	gcc -g -no-pie -o main main.o printInt.o -lc

clean:
	rm -f main main.o printInt.o
