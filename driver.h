#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

#define THRESHOLD 5

unsigned char *allocate_memory(int );
int read_image(FILE *, unsigned char *, unsigned char *, 
          unsigned char *, int, int, int);
void ave_image(unsigned char *, unsigned char *, unsigned char *G, 
	  unsigned char *, int, int);
void step1(unsigned char *, unsigned char *, unsigned char *G, 
          int, int);