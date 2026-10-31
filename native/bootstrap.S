/* Author: @Jhih he. Own allocation; appended resident blob supplied by build.py. */
.syntax unified
.arm
.text
.global entry
.macro CALL address
 movw ip, #:lower16:\address
 movt ip, #:upper16:\address
 blx ip
.endm
entry:
 push {r4-r8,lr}
 sub sp,sp,#16
 mov r0,#0
 str r0,[sp]
 str r0,[sp,#4]
 str r0,[sp,#8]
 str r0,[sp,#12]
 mov r0,sp
 mov r1,#0
 movw r2,#BLOB_LEN
 mov r3,#0
 CALL 0xC001D740
 mov r0,sp
 CALL 0xC001D7F0
 movs r4,r0
 beq 9f
 adr r5,blob
 mov r6,r4
 movw r7,#BLOB_LEN
1: ldr r8,[r5],#4
 str r8,[r6],#4
 subs r7,r7,#4
 bne 1b
 CALL 0xC000E91C
 CALL 0xC000EABC
 mov r0,r4
 blx r4
9: add sp,sp,#16
 mov r0,#0
 pop {r4-r8,pc}
.align 2
blob:
