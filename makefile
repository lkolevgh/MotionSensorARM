detection: read_image.o driver.o allocate_memory.o ave_image.o step1.o read_int.o modulo.o step2.o step3.o find_next.o find_connected.o step4.o step5.o step6.o
	gcc -o detection read_image.o driver.o allocate_memory.o ave_image.o step1.o read_int.o modulo.o step2.o step3.o find_next.o find_connected.o step4.o step5.o step6.o -lm -L . -lutil

read_image.o: read_image.s
	gcc -c -g read_image.s

driver.o: driver.s
	gcc -c -g driver.s

modulo.o: modulo.s
	gcc -c -g modulo.s

allocate_memory.o: allocate_memory.c
	gcc -c -g allocate_memory.c

ave_image.o: ave_image.s
	gcc -c -g ave_image.s

find_next.o: find_next.s
	gcc -c -g find_next.s

find_connected.o: find_connected.s
	gcc -c -g find_connected.s

step1.o: step1.s
	gcc -c -g step1.s

step2.o: step2.s
	gcc -c -g step2.s

step3.o: step3.s
	gcc -c -g step3.s

step4.o: step4.s
	gcc -c -g step4.s

step5.o: step5.s
	gcc -c -g step5.s

step6.o: step6.s
	gcc -c -g step6.s

read_int.o: read_int.c
	gcc -c -g read_int.c

clean:
	rm *.o detection
