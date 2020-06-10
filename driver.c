#include "driver.h"


int main()
{
    unsigned char *R, *G, *B, *Iout, *frameT, *frameTp1;
    int height, width, padding, filesize, offset;
    FILE *fpin;
    char filename[80] = "frame1.bmp";

    fpin = fopen(filename, "rb");

    filesize = read_int(fpin, 2);
    offset = read_int(fpin, 10);
    width = read_int(fpin, 18);
    height = read_int(fpin, 22);
    
    padding = 0;
    if ( (3*width)%4 != 0)
        padding = 4 - ( (3*width)%4 );

    // Allocate memory
    B = allocate_memory(width*height);
    G = allocate_memory(width*height);
    R = allocate_memory(width*height);
    Iout = allocate_memory(width*height);
    frameT = allocate_memory(width*height);
    frameTp1 = allocate_memory(width*height);

    fclose(fpin);

    int i;
    for (i = 1; i < 4; i++)
    {
        char temp[80];
        strcpy(filename, "frame");
	sprintf(temp, "%d", i);
        strcat(filename, temp);
        strcat(filename, ".bmp");
        
        fpin = fopen(filename, "rb");
        read_image(fpin, B, G, R, height, width, padding);
        ave_image(frameT, B, G, R, height, width);
        fclose(fpin);

        strcpy(filename, "frame");
        sprintf(temp, "%d", i+1);
        strcat(filename, temp);
        strcat(filename, ".bmp");

        fpin = fopen(filename, "rb");
        read_image(fpin, B, G, R, height, width, padding);
        ave_image(frameTp1, B, G, R, height, width);
        fclose(fpin);

        step1(frameT, frameTp1, Iout, height, width);

        int k;
        for (k = 0; k < height; k++)
        {
            printf("%c\n", *(Iout+k));
        }

     }  // for

     free(Iout);
     free(B);
     free(G);
     free(R);
     free(frameT);
     free(frameTp1);

     return 0;
}  // end main