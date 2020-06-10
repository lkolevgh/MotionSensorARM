.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global step4
.type step4, %function

step4:
    push {fp, lr}
    add fp, sp, #4

    mov r3, #0  @ CONSTANT R 
    mov r4, #0  @ int i
    mov r5, #0  @ int j 
    mov r6, #0  @ int size
    ldr r7, [fp, #-24]  @ load mlables to r7    

    mov r4, #1         
    @ for (i = 1; i <= mlabels; i++) 
    loopback:
    cmp r4, r7 
    bgt next
    mov r6, #0  @ size = 0 
    @ for (j = 0; j<= height * width; j++)
    ldr r0, [fp, #-36]  @ load width
    ldr r1, [fp, #-32]  @ load height 
    mul r3, r0, r1 
    loopback2:
    cmp r5, r3
    bge next2
    @ if ((label + j ) == i)
    ldr r0, [fp, #-24]  @ load label 
    add r0, r0, r5  @ label + j 
    cmp r0, r4
    bne next3 
    add r6, r6, #1  @ size += 1 
    next3:
   
    b loopback2 
    next2:     

    @if (size == 0 )
    mov r0, #0
    cmp r0, r6
    bne next4 
    b loopback 
    next4:  
    @ int current_label = i 
    str r4, [fp, #-24] 
    
    mov r8, #0  @ int r
    mov r9 ,#0  @ int c

    @ for ( r= 0 ; r< height- r + 1; r++ )
    loopback3:
    ldr r0, [fp, #32]  @ load height
    sub r0, r0, r8
    add r0, r0, #1 
    cmp r8, r0  
    bge next5 
    add r8, r8, #1   @ r++ 
    @ for ( c= 0 ; c< width- R + 1; c++ )
    loopback4:
    ldr r0, [fp, #36]  @ load width
    sub r0, r0, r8
    add r0, r0, #1  @ (width - r) +1
    cmp r8, r0  
    bge next6 
    add r9, r9, #1   @ c++ 
 
    mov r0, #0   @ int m 
    mov r1, #0   @ int n

    push {r0, r1}  @ push variables onto stack because of lack of register space

    @ for ( n= 0 ; n< r + R ; n++ )
    loopback5:
    add r0, r8, r3  @ r + R  
    cmp r8, r0  
    bge next6 
    ldr r0, [fp, #-44]  @ access n on stack  
    add r0, r0, #1
    str r0, [fp, #-44]  @ n++ 
    @ for ( m= c ; m < c + R ; m++ )
    loopback6:
    sub r0, r0, r8
    add r0, r0, #1  @ (width - r) +1
    cmp r8, r0  
    bge next7 
    add r9, r9, #1   @ c++ 
    b next8
  
    b loopback6
    next8:

    b loopback5
    next7:


    b loopback4
    next6:

 
    b loopback3
    next5:


    b loopback
    next:

    done:
    sub sp, fp, #4
    pop {fp, pc}
