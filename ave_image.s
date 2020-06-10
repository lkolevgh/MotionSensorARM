.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global ave_image
.type ave_image, %function

ave_image:
    push {fp, lr}
    add fp, sp, #4

    

    mov r4, #0  @ i = 0 
    ldr r0, [fp, #32]
    ldr r1, [fp, #36]
    mul r5, r0, r1
    @for (i = 0; i < height*width; i++)
    cmp r4, r5
    bge next
    @unsigned char temp;
    mov r7, #0    

    @temp = *(B+i) + *(G+i) + *(R+i);
    ldr r0, [fp, #24]
    mov r1, r4 
    add r2, r0, r1  @(B + i) 
    ldr r0, [fp, #20]
    mov r1, r4
    add r3, r0, r1   @ (G +i )
    ldr r0, [fp, #16]
    mov r1, r4
    add r6, r0, r1  @ (R+ i) 
    add r2, r2, r3
    add r7, r6, r2
    
    @temp = temp / 3;
    mov r0, #0 
    udiv r7, r7, r0
     
    @*(out+i) = temp;
    mov r0, r7

    next:

    done:
    sub sp, fp, #4
    pop {fp, pc}
