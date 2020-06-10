.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global step5
.type step5, %function

step5:
    push {fp, lr}
    add fp, sp, #4

    mov r4, #1   @  int i
    mov r5, #0   @  int r
    mov r6, #0   @  int c
    mov r7, #0   @  int j

    @ for (i = 1; i < = mlabels; i++)
    ldr r0, [fp, #-28]   @ load mlabels  
    loopback:
    cmp r4, r1  
    bgt next 
    add r4, r4, #1 
    mov r8, #0  @int size = 0 
    
    @ for (j = 0; i < heigh*width; j++)
    loopback2:
    ldr r0, [fp, #-36]  @ load width
    ldr r1, [fp, #-32]  @ load height  
    mul r0, r0, r1
    cmp r4, r0 
    bge next2

    @ if (label + j ) = = i
    ldr r0, [fp, #-20]   @ load label 
    add r0, r7 ,r0   @ label + j 
    cmp r0, r4 
    bne next3
    add r8, r8, #1   @ size += 1
    next3:

    @for ( r = ul-r; r <= lr_r ; r++)
    loopback3:
    cmp r5, r8 
    bgt next4
    add r5, r5, #1 
     
    @ for ( c = ul_c; c <= lr_c; c++)
    loopback4:
    cmp r6, r8 
    bgt next5 
    add r6, r6, #1
    @ *( label + r *width +c ) = i 
    ldr r0, [fp, #36]  @ load width
    mul r0, r0, r5   @ r * width 
    ldr r1, [fp, #-36]  @ load label 
    add r0, r0, r1
    add r0, r0, r6 
    str r4, [r0]   @ load i into *( label + r *width +c ) 


    b loopback4
    next5:

    
    b loopback3
    next4:


    b loopback2
    next2:


    b loopback
    next:      

    done:
    sub sp, fp, #4
    pop {fp, pc}
