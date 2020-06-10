#include "driver.h"

void step1(unsigned char *fT, unsigned char *fTp1, unsigned char *Iout, 
          int height, int width)
{

    int i;

    for (i = 0; i < height*width; i++)
    {
        unsigned char temp;

        *(Iout + i) = 0;
        temp = *(fT+i) - *(fTp1 + i);
        temp = abs(temp);

        if (temp > THRESHOLD)
            *(Iout + i) = 1;

    }

}