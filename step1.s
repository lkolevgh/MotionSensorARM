.cpu cortex-a53
.fpu neon-fp-armv8

.data

.text
.align 2
.global step1
.type step1, %function

step1:
    push {fp, lr}
    add fp, sp, #4


    mov r4, #5  @treshold 
    mov r5, #0   @ int i
    ldr r0, [fp, #36]  @ load width
    ldr r1, [fp, #32]  @ load height  
    mul r6, r0, r1  @ weight * height 
    mov r8, #0  @for byte offset
    ldr r9, [r10, #12]   @get Iout from r10 
 
    @for (i = 0; i < height*width; i++)
    loopback:
    cmp r5, r6
    bge next
    @ unsigned char temp 
    mov r7, #0

    @ *(Iout + i) = 0;
    mov r0, #0 
    add r1, r9, r5
    @ldr r1, [fp, #12]  @ load Iout
    str r1, [r9]
    

    @ IMPLEMENT BYTE OFFSET 
    @temp = *(fT+i) - *(fTp1 + i);
    ldr r0, [r9, #16]  @retrieve ft 
    @mul r1, r5, r8  @byte offset
    add r0, r0, r5   @(ft + i)
    ldr r1, [fp, #4]  @retrieve ftp1
    @mul r1, r5, r8  @byte offset
    add r1, r1, r5   @ (ftp1 + i)
    sub r0, r0, r1
    mov r7, r0  @ temp = result
    
    @ temp = abs(temp) 
    @ldr r0, r7 
    bl abs
    mov r7, r0

    @if (temp > THRESHOLD)
    cmp r7, r4
    ble next2
    @*(Iout + i) = 1;
    mov r0, #1
    str r0, [r9, r5]
     
    
    next2:


    add r5, r5, #1  @i++
    b loopback
   
    next:

    done:
    sub sp, fp, #4
    pop {fp, pc}
