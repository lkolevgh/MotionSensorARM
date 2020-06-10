#include <stdio.h>

int read_int(FILE *fp, int sbyte)
{
     int value = 0;
     int shift = 0;

     fseek(fp, sbyte, SEEK_SET);
     
     int i;

     for (i = 0; i < 4; i++)
     {
         unsigned char c;
         c = fgetc(fp);
         value += ((int) c) << shift;
         shift += 8;
     }

     return value;
}