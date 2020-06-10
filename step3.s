.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global step3
.type step3, %function

step3:
    push {fp, lr}
    add fp, sp, #4

    mov r4, #0  @ int i
    mov r5, #0  @ int j
    mov r6, #0  @ count
    mov r7, #0  @ mlabels  
    mov r9, #5  @ SMALL CONSTANT 
 
    @ for (i = 1; i<= mlabels; i++)
    mov r4, #1
    loopback:
    cmp r4, r7
    bgt next
    add r4, r4, #1  @i++
    mov r6, #0  @ count = 0 
    @ for (j = 0; j<= height * width; j++)
    ldr r0, [fp, #-36]  @ load width
    ldr r1, [fp, #-32]  @ load height 
    mul r3, r0, r1 
    loopback2:
    cmp r5, r3
    bge next2
    @ if ((label + j ) == label)
    ldr r0, [fp, #-24]  @ load label 
    add r0, r0, r5  @ label + j 
    ldr r1, [fp, #-24]  @ load label 
    cmp r0, r1 
    bne next3
    add r6, r6, #1  @ count += 1
    next3: 
    @ if (count <= SMALL) 
    cmp r6, r9
    bgt next4
    @ for (j = 0; j<= height * width; j++)
    ldr r0, [fp, #-36]  @ load width
    ldr r1, [fp, #-32]  @ load height 
    mul r3, r0, r1 
    next4:
    loopback3:
    cmp r5, r3
    bge next5
    @ if ((label + j ) == i)
    ldr r0, [fp, #-24]  @ load label 
    add r0, r0, r5  @ label + j 
    cmp r0, r4
    bne next6
    ldr r0, [fp, #-24]  @ load label 
    add r0, r0, r5  @ label + j 
    mov r1, #0 
    str r1, [r0] 
    next6:    

    b loopback3 

    next5:

    b loopback2 

    next2: 
    
    b loopback

    next:
    
    done:
    sub sp, fp, #4
    pop {fp, pc}
