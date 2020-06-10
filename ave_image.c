
// Average R, G, B images
void ave_image(unsigned char *out, unsigned char *B, unsigned char *G, 
	  unsigned char *R, int height, int width)
{

    int i;

    for (i = 0; i < height*width; i++)
    {
        unsigned char temp;
 
        temp = *(B+i) + *(G+i) + *(R+i);
        temp = temp / 3;
        *(out+i) = temp;
     }
}