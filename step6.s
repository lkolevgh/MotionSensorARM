.cpu cortex-a53
.fpu neon-fp-armv8

.data
promptwrite: .asciz "wb"
outfile: .asciz "frame.bmp"

.text
.align 2
.global step6
.type step6, %function

step6:
    push {fp, lr}
    add fp, sp, #4

    @int k 
    @mov r5, #0
    @ldr r6, [fp, #-24]  @ load height 
    @ for (k =0; k <height: k++)
    @loopback2:
    @cmp r5, r6
    @bge next3
    @printf("%c\n", *(Iout +k)) 
    @ldr r7, [fp, #-44]  @ load  Iout 
    @add r1, r7, r5
    @ldr r0, =char 
    @bl printf
    @add r5, r5, #1   

    done:
    sub sp, fp, #4
    pop {fp, pc}
