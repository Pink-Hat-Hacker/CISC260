isPalindrome(char*):
        push    {r11, lr}
        mov     r11, sp
        sub     sp, sp, #16
        str     r0, [r11, #-4]
        mov     r0, #0
        str     r0, [sp, #8]
        ldr     r0, [r11, #-4]
        bl      strlen
        sub     r0, r0, #1
        str     r0, [sp, #4]
        b       .LBB0_1
.LBB0_1:                                @ =>This Inner Loop Header: Depth=1
        ldr     r0, [sp, #4]
        cmp     r0, #2
        blt     .LBB0_5
        b       .LBB0_2
.LBB0_2:                                @   in Loop: Header=BB0_1 Depth=1
        ldr     r0, [r11, #-4]
        ldr     r1, [sp, #8]
        add     r2, r1, #1
        str     r2, [sp, #8]
        ldrb    r0, [r0, r1]
        ldr     r1, [r11, #-4]
        ldr     r2, [sp, #4]
        sub     r3, r2, #1
        str     r3, [sp, #4]
        ldrb    r1, [r1, r2]
        cmp     r0, r1
        beq     .LBB0_4
        b       .LBB0_3
.LBB0_3:
        ldr     r0, .LCPI0_1
        bl      printf
        b       .LBB0_6
.LBB0_4:                                @   in Loop: Header=BB0_1 Depth=1
        b       .LBB0_1
.LBB0_5:
        ldr     r0, .LCPI0_0
        bl      printf
        b       .LBB0_6
.LBB0_6:
        mov     sp, r11
        pop     {r11, lr}
        bx      lr
.LCPI0_0:
        .long   .L.str.1
.LCPI0_1:
        .long   .L.str
.L.str:
        .asciz  "Not  palindrome"

.L.str.1:
        .asciz  "Palindrome"