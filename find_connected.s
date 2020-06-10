.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global find_connected 
.type find_connected, %function

find_connected:
    push {fp, lr}
    add fp, sp, #4

    @ r8 = cur_loc 
 
    mov r5, #0  @ int r 
    mov r6, #0  @ int c
    mov r7, #0  @ int i 
    push {r5, r6, r7}  @  push values onto stack for effiency
    mov r5, #0  @j 
    push {r5}    
    mov r9, #0  @ int done = 0 

    @ while(!done)
    mov r5, #1
    loopback: 
    cmp r9, r5
    beq done
     
    @  r = current_loc /width
    mov r0, r8  @ r8 = current_loc 
    ldr r1, [fp, #36]   @ load width 
    udiv r0, r0, r1 
    str r0, [fp, #-8]  @ store result into r 

    @  c = current_loc /width
    mov r0, r8  @ r8 = current_loc 
    ldr r1, [fp, #36]   @ load width 
    udiv r0, r0, r1 
    str r0, [fp, #-12]  @ store result into c
    mov r9, #1  @done = 1 
    
    @ for ( i = r-1 ; i <= r+1 ; i++)
    ldr r1, [fp, #-8]  @ retrieve r 
    mov r0, #1
    sub r0, r1, r0 
    mov r7, #0  @ i = r-1 
    ldr r1, [fp, #-8]  @ retrieve r 
    mov r0, #1
    add r0, r1, r0 
    mov r8, #0  @ i = r+1 
    

    loopback2:
    cmp r7, r8 
    bgt next 
    @ if (i<0 OR I>= HEIGHT) continue
    mov r0, #0 
    ldr r1, [fp, #-16]  @load i 
    cmp r0 ,r1
    bge next2
    b loopback
    next2:
    mov r0, #0 
    ldr r1, [fp, #-16]  @load i 
    cmp r0, r1 
    bgt loopback  @ continue
    
    @ for ( j = c-1 ; j <= c+1 ; j++)
    ldr r1, [fp, #-12]  @ retrieve c 
    mov r0, #1
    sub r0, r1, r0 
    str r0, [fp, #-20]  @ j = r-1 
    ldr r1, [fp, #-12]  @ retrieve c 
    mov r0, #1
    add r0, r1, r0 
    str r0, [fp, #-20]  @ i = r+1 
     
    @ if (j< 0 OR J>= WIDTH)
    mov r0, #0 
    ldr r1, [fp, #-20]  @load J 
    cmp r0 ,r1
    bge loopback
    next3:
    ldr r0, [fp, #-36]  @ get width
    ldr r1, [fp, #-20]  @load J 
    cmp r0, r1 
    bgt loopback

    @ if i == j 
    ldr r1, [fp, #-20]  @load J 
    ldr r0, [fp, #-16]  @load i 
    cmp r0, r1
    bne next4
 
    next4:
    
    @if (Iout + i * width + j) == 1 
    ldr r0, [fp, #-16]   @ load i 
    ldr r1, [fp, #36]  @ load width 
    mul r0, r0 ,r1
    ldr r1, [r10, #12]  @ get Iout 
    add r0, r1, r0
    ldr r1, [fp, #-20]  @ get J
    add r0, r1, r0 
    mov r1, #1 
    cmp r0, r1
    bne next5
    @ *(visited + i * width + j) == 0 
    ldr r0, [fp, #-16]   @ load i 
    ldr r1, [fp, #36]  @ load width 
    mul r0, r0 ,r1
    mov r1, r8  @ get visted 
    add r0, r1, r0
    ldr r1, [fp, #-20]  @ get J
    add r0, r1, r0 
    mov r1, #0 
    cmp r0, r1
    bne next6

    next6:
    mov r9, #0  @ set done to 0
    add sp, sp, #4
    @ stack [*sp] = i * width + j 
    ldr r0, [fp, #-16]   @ load i 
    ldr r1, [fp, #36]  @ load width 
    mul r0, r0 ,r1
    ldr r1, [fp, #-20]  @ get J
    add r0, r1, r0 
    str r0, [sp]
    @ current_loc = i * width + j 
    ldr r0, [fp, #-16]   @ load i 
    ldr r1, [fp, #36]  @ load width 
    mul r0, r0 ,r1
    ldr r1, [fp, #-20]  @ get J
    add r0, r1, r0 
    str r0, [r4]  @ current_location = i *width + j 
          
    next5: 

    next:

    done:
    sub sp, fp, #4
    pop {fp, pc}
