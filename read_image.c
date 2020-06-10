#include <stdio.h>

int read_image(FILE *fpin, unsigned char *B, unsigned char *G,
               unsigned char *R, int height, int width, int padding)
{

     int size = 0;  // size of message

     int r, c;

     for (r = 0; r < height; r++)
     {
         for (c = 0; c < width; c++)
         {
              *(B + r*width + c) = (unsigned char)(fgetc(fpin));
              *(G + r*width + c) = (unsigned char)(fgetc(fpin));
              *(R + r*width + c) = (unsigned char)(fgetc(fpin));
         }
         fseek(fpin, padding, SEEK_CUR);
     }

     size = (int)(*B) + (int)( (*G) << 8 ) + (int)( (*R) << 16 );

     return size;
}