.cpu cortex-a53
.fpu neon-fp-armv8

.data
prompt: .asciz "rb"
promptwrite: .asciz "wb"
digit: .asciz "%d"
char: .asciz "%c\n"
bmp: .asciz ".bmp"
filename: .asciz "frame1.bmp" 
frame: .asciz "frame"
outfile: .asciz "frame1.bmp"

.equ treshold, "#1"
.text
.align 2
.global main
.type main, %function

main:
    push {fp, lr}
    add fp, sp, #4

    @unsigned char *R, *G, *B, *Iout, *frameT, *frameTp1;
    mov r0, #24
    bl malloc 
    mov r10, r0  @ Unsigned char variables are stored safetly in r10 

    @FILE *fpin = fopen  (fname, "rb");
    ldr r0, =filename 
    ldr r1, =prompt 
    bl fopen 
    mov r4, r0 
    push {r4}

    @@@START read_int function calls
    @ filesize = read_int(fpin, 2)
    @ldr r1, [fp, #-8]  @retrieve fpin from stack 
    mov r0, r4  
    mov r1, #2 
    bl read_int 
    mov r6, r0  @result is stored in r0
    push {r6}   @push filesize onto stack
 
    @ offset = read_int(fpin, 10)
    @ldr r1, [fp, #-8]  @retrieve fpin from stack 
    mov r0, r4  
    mov r1, #10 
    bl read_int 
    mov r5, r0  @result is stored in r0
    push {r5}   @push offset onto stack

    @ width = read_int(fpin, 18)
    @ldr r1, [fp, #-8]  @retrieve fpin from stack 
    mov r0, r4  
    mov r1, #18 
    bl read_int 
    mov r8, r0  @result is stored in r0
    push {r8}   @push width onto stack

    @ height = read_int(fpin, 22)
    @ldr r1, [fp, #-8]  @retrieve fpin from stack 
    mov r0, r4  
    mov r1, #22
    bl read_int 
    mov r9, r0  @result is stored in r0
    push {r9}   @push height  onto stack

  
    @ padding = 0 
    mov r5, #0  
    push {r5}
    @if ( (3*width)%4 != 0)
        @padding = 4 - ( (3*width)%4 );
    ldr r0, [fp, #-20]   @ load width
    mov r1, #3
    mul r0, r0, r3 
    mov r4, #4
    bl modulo  
    @ modulo remainder returned in r0
    mov r0, #0
    beq next
    @padding = 4 - ( (3*width)%4 );
    ldr r0, [fp, #-20]   @ load width
    mov r1, #3
    mul r0, r0, r3 
    mov r4, #4
    bl modulo  
    @ modulo remainder returned in r0
    mov r1, #4
    sub r0, r1, r0
    str r0, [fp, #-28]  @store result in padding on stack

    next:

    @@@@ Allocate memory 
    @ B 
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare B
    push {r5}  @ Push B onto stack 
    str r0, [fp, #-32]   @ store malloc value into B 

    @ G
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare G
    push {r5}  @ Push G onto stack 
    str r0, [fp, #-36]   @ store malloc value into G 

    @ R
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare R
    push {r5}  @ Push R onto stack 
    str r0, [fp, #-40]   @ store malloc value into R 

    @ Iout
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare Iout 
    push {r5}  @ Push Iout onto stack 
    str r0, [fp, #-44]   @ store malloc value into Iout 

    @ frameT
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare frameT 
    push {r5}  @ Push Iout onto frameT 
    str r0, [fp, #-48]   @ store malloc value into frameT

    @ frameTp1
    ldr r0, [fp, #-20]  @ load width
    ldr r1, [fp, #-24]  @ load height
    mul r0, r0, r1
    bl malloc
    mov r5, #0  @ Declare frameTp1 
    push {r5}  @ Push Iout onto frameTp1 
    str r0, [fp, #-52]   @ store malloc value into frameTp1

    @ fclose = (fpin)
    ldr r0, [fp, #-8]
    bl fclose 
    @fclose(fp)

    @int i
    mov r5, #1  @int i 
    mov r6, #4
    @for (i = 1; i < 4; i++)
    loopback:
    cmp r5, r6
    bge next2
    add r5, r5, #1  @i++ 
    @char temp[80];
    mov r0, #80 
    bl malloc
    mov r8, r0 
    @strcpy(filename, "frame");
    ldr r0, =frame
    ldr r1, =filename
    bl strcpy    
    @sprintf(temp, "%d", i);
    ldr r0, [fp, #4]
    ldr r1, =digit
    mov r2, r5 
    bl sprintf
    @strcat(filename, temp);
    ldr r0, =filename
    ldr r1, [fp, #4]  @ temp
    bl strcat 
    @strcat(filename, ".bmp");
    ldr r0, =filename
    ldr r1, =bmp
    bl strcat 

    @fpin = fopen(filename, "rb");
    ldr r0, =filename 
    ldr r1, =prompt 
    bl fopen 
    mov r4, r0 
    @push {r4}
    @read_image(fpin, B, G, R, height, width, padding);
    @ Set up parameters for passing 
    ldr r0, [fp, #-8]
    ldr r1, [fp, #-32]
    ldr r2, [fp, #-36]
    ldr r3, [fp, #-40]
    bl read_image
    @ave_image(frameT, B, G, R, height, width);
    bl ave_image
    @fclose(fpin);     
    ldr r0, [fp, #-8]
    bl fclose 

    @@@@@@ START STEPS 

    @step1(frameT, frameTp1, Iout, height, width) 
    bl step1

    @step2(unsigned char *Iout, height, width) 
    bl step2
    
    @step3(unsigned char *label, int height , int width, nlabels) 
    bl step3     

    @step4(unsigned char *label, int height , int width, nlabels)  
    bl step4   

    @step5(unsigned char *label, int height , int width, nlabels) 
    bl step5 

    @step6(unsigned char *label, int height , int width, nlabels) 
    bl step6 
 
    @@@@@@@

    @int k 
    mov r5, #0
    ldr r6, [fp, #-24]  @ load height 
    @ for (k =0; k <height: k++)
    loopback2:
    cmp r5, r6
    bge next3
    @printf("%c\n", *(Iout +k)) 
    ldr r7, [fp, #-44]  @ load  Iout 
    add r1, r7, r5
    ldr r0, =char 
    bl printf
    add r5, r5, #1 
    b loopback2

    next3: 
    
    b loopback
 
    next2: 

    @ free(Iout)
    ldr r0, [fp, #-44]
    bl free

    @ free(B)
    ldr r0, [fp, #-32]
    bl free

    @ free(G)
    ldr r0, [fp, #-36]
    bl free

    @ free(R)
    ldr r0, [fp, #-40]
    bl free

    @ free(frameT)
    ldr r0, [fp, #-48]
    bl free

    @ free(frameTp1)
    ldr r0, [fp, #-52]
    bl free

    done:
    sub sp, fp, #4
    pop {fp, pc}


