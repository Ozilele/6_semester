clib.so: clib.o
	gcc -shared -o clib.so clib.o

clib.o: clib.c
	gcc -c -o clib.o clib.c

clean:
	rm -f clib.so clib.o