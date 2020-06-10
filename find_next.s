.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global find_next 
.type find_next, %function

find_next:
    push {fp, lr}
    add fp, sp, #4

    @ visted = r4 

    mov r5, #0  @ int i 
    mov r6, #0  @int temp_index 
    
    ldr r7, [sp]
    
    @if (sp = -1)
    cmp r5, r7
    bne next 
    ldr r0, [fp, #-8]  @ load label number
    mov r1, #1 
    add r0, r0 , r1  @ label_number + 1 
    
    ldr r0, [fp, #36]   @load width  
    ldr r1, [fp, #32]   @load height
    mul r8, r1, r0

    @for (i = current_loc; i < height*width; i++)  
    loopback:
    cmp r5, r8 
    bge next2 

    @ if ((Iout +i) != 0 && *(visted +i) == 0) 
    mov r0, #0 
    ldr r1, [r10, #12]  @retreive Iout 
    add r1, r1, r4
    cmp r0, r1
    beq next3
    mov r0, #0 
    mov r1, r4 
    add r1, r1, r5
    cmp r0, r1 
    bne next4

    @ (visited + i ) =1 
    mov r0, #1
    add r1, r4, r5  
    str r0, [r1]   
    mov r0 , r5   @ return i 

    b done   

    next4:

    next3:

    next2:

    next:
    mov r0, #-1 


    done:
    sub sp, fp, #4
    pop {fp, pc}
