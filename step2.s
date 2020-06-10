.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global step2
.type step2, %function

step2:
    push {fp, lr}
    add fp, sp, #4

    mov r4, #0  @ int visited 
    
    mov r0, #4 
    bl malloc 
    mov r5, r0  @unsigned char *label 

    @int stack [1000] 
    mov r0, #250
    mov r1, #16  @ 4 * 4 bytes
    mul r6, r0, r1  @ r5 = 250 * (4 * 4 bytes) = 4000
    
    @sp = -1 
  
    @ label_number = 0 
    mov r7, #0 

    @ cur_loc = 0 
    mov r8, #0 

    @visited = (int *) malloc(height*width *4)
    ldr r0, [fp, #36]   @load width  
    ldr r1, [fp, #32]   @load height
    mul r0, r1, r0
    mov r1, #4
    mul r0, r1, r0 
    bl malloc   @ result returned in r0 
    mov r4, r0  @ visit = malloc(height*width *4)
    

    @ label = (unsigned *) malloc (height * width)    
    ldr r0, [fp, #36]   @load width  
    ldr r1, [fp, #32]   @load height
    mul r0, r1, r0
    bl malloc   @ result returned in r0 
    mov r5, r0   @label = (unsigned *) malloc (height * width)  

    @ current_loc = find_next(Iout, viste, cur_loc)

    @ int i 
    mov r8, #0 

    ldr r0, [fp, #36]   @load width  
    ldr r1, [fp, #32]   @load height
    mul r9, r1, r0

    @for (i = 0 ; i < height*width; i++)
    loopback:
    cmp r8, r9 
    bge next
    @ * (visited + i) = 0 
    mov r0, #0 
    add r1, r4, r8 
    str r1, [r4]
    mov r0, #0 
    add r1, r5, r8
    strb r1, [r5]  @ * (label  + i) = 0 


    next:
    mov r9, #0   @ cur_loc
    mov r4, #-1  
    @ while  current_loc != -1)
    loopback2:
    cmp r9, r4
    beq next2
    @for (i =0 ; i<= current_loc, i++) 
    @ * (visited + i) = 1 
    mov r0, #1 
    add r1, r4, r8 
    str r1, [r4] 

    @ push current_loc onto stack 
    push {r9}

    @ find_connected (Iout, stack, sp ,visited )
   
    @cur_loc = find_next(Iout, visited, current_loc, stack, sp, *label_number 

    @if (current_loc != -1)
    mov r0, #0  
    cmp r9, r0 
    beq next3 
    @ * (visited + cur_loc) = 1 
    mov r0, #1  
    add r1, r4, r7
    str r0, [r1]

    next3:
    b loopback2

    next2:
    ldr r0, [r10, #12]
    bl free

    mov r0, r5  @return label 

    
    done:
    sub sp, fp, #4
    pop {fp, pc}
