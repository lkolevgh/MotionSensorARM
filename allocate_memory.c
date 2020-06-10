#include "driver.h"

// Allocate memory
unsigned char *allocate_memory(int size)
{
    unsigned char *temp;

    temp = (unsigned char *) malloc(size);

    return temp;
}