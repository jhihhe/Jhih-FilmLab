.include "native/data/hud-font.inc"
/* Author: @Jhih he. Sigma fp 5.02; firmware ABI evidence in docs.
 * Recipe data copyright André Domingues, MIT, vendor/sony-recipe-lab.
 * PIC, own allocation. Worker owns firmware calls; observer only queues IDs.
 */
.syntax unified
.arm
.text
.include "native/data/catalog.inc"
.include "native/state-abi.inc"
.macro CALL address
 movw ip, #:lower16:\address
 movt ip, #:upper16:\address
 blx ip
.endm
/* Arbitrary-distance PIC pointer without unsupported ADR fixups. */
.macro PTR reg,label
 ldr \reg,991f
992: add \reg,pc,\reg
 b 993f
991: .word \label-(992b+8)
993:
.endm
.global entry
entry:
 push {r4-r8,lr}
 sub sp,sp,#32
 PTR r4,state
 PTR r5,vtable
 str r5,[r4]
 PTR r0,destruct
 str r0,[r5,#8]
 PTR r0,notify
 str r0,[r5,#12]
 mov r0,#0
 str r0,[sp]
 mov r0,#0x41
 str r0,[sp,#4]
 PTR r0,worker
 str r0,[sp,#8]
 mov r0,#28
 str r0,[sp,#12]
 mov r0,#0x2000
 str r0,[sp,#16]
 movw r0,#0x4352
 movt r0,#0x5045
 str r0,[sp,#20]
 mov r0,#0
 str r0,[sp,#24]
 str r0,[sp,#28]
 mov r0,sp
 CALL 0xC0016A58
 cmp r0,#1
 blt task_error
 mov r1,#0
 CALL 0xC0016BC0
 cmp r0,#0
 bge 1f
task_error:
 PTR r0,task_error_label
 bl show_label
1: add sp,sp,#32
 pop {r4-r8,pc}
destruct: bx lr
/* state: 0 vtable;4 held;8 requested;12 applied;16 object;20 original
 * color;24 original WB;28 original K;32 WB touched bits;36 ready;
 *40..219 color snapshots (15*12);232..247 WB snapshots (2*8);
 *228 retry ticks;264..383 Effect/Toning;384 serial menu owner;388 state ABI marker.
 * Color enum has 16 values, but OFF has no parameter slot. Slot12=PowderBlue,
 * slot13=DuoTone, slot14=WarmGold. Slot15 is invalid and asserts firmware. */
notify:
 ldr r2,[r0,#220]
 str r2,[r0,#248]
 str r1,[r0,#220]
 ldr r2,[r0,#224]
 add r2,r2,#1
 str r2,[r0,#224]
 cmp r1,#0x24
 moveq r2,#1
 streq r2,[r0,#4]
 beq 9f
 cmp r1,#0x25
 moveq r2,#0
 streq r2,[r0,#4]
 beq 9f
 /* Direction events can be filtered by OEM combination handling.
  * Observer handles AEL and OK only; worker reads physical direction edges. */
 cmp r1,#0x1c
 bne 9f
navigation:
 ldr r2,[r0,#FILMLAB_MENU_OWNER]
 cmp r2,#0
 bne 9f
 ldr r2,[r0,#4]
 cmp r2,#0
 beq 9f
 ldr r2,[r0,#8]
 cmp r1,#0x1c
 moveq r2,#0
 beq 8f
 cmp r1,#0xc
 addeq r2,r2,#1
 beq 7f
 cmp r1,#0x10
 bne 1f
 cmp r2,#0
 moveq r2,#(RECIPE_COUNT+1)
 sub r2,r2,#1
 b 7f
1: cmp r1,#0x14
 addeq r2,r2,#10
 beq 7f
 cmp r1,#0x18
 subeq r2,r2,#10
 bne 9f
7: cmp r2,#RECIPE_COUNT
 subgt r2,r2,#RECIPE_COUNT
 cmp r2,#1
 addlt r2,r2,#RECIPE_COUNT
8: str r2,[r0,#8]
9: mov r0,#1
 bx lr
worker:
 PTR r4,state
 mov r0,#5000
 CALL 0xC03705D8
 CALL 0xC0057AE8
 str r0,[r4,#16]
 CALL 0xC005C990
 str r0,[r4,#20]
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 str r0,[r4,#24]
 ldr r0,[r4,#16]
 bl get_kelvin_raw
 str r0,[r4,#28]
 mov r5,#0
 add r6,r4,#40
snapshot_color:
 ldr r0,[r4,#16]
 mov r1,r5
 CALL 0xC005CAD0
 str r0,[r6]
 ldr r0,[r4,#16]
 mov r1,r5
 CALL 0xC005CB70
 str r0,[r6,#4]
 ldr r0,[r4,#16]
 mov r1,r5
 CALL 0xC005CC10
 str r0,[r6,#8]
 add r7,r4,#264
 add r7,r7,r5,lsl #3
 ldr r0,[r4,#16]
 mov r1,r5
 bl get_effect_raw
 str r0,[r7]
 ldr r0,[r4,#16]
 mov r1,r5
 CALL 0xC005CCB0
 str r0,[r7,#4]
 add r6,r6,#12
 add r5,r5,#1
 cmp r5,#15
 blt snapshot_color
 CALL 0xC02DBAF0
 mov r5,r0
 sub sp,sp,#8
 add r1,r5,#0x20
 mov r0,sp
 CALL 0xC0010298
 mov r6,#0
2: ldr r0,[r5,r6]
 cmp r0,#0
 beq 3f
 add r6,r6,#4
 cmp r6,#28
 blt 2b
 b 4f
3: mov r0,r5
 mov r1,r4
 CALL 0xC00576B8
 mov r0,#1
 str r0,[r4,#36]
4: mov r0,sp
 mov r1,#2
 CALL 0xC00102D0
 add sp,sp,#8
 ldr r0,[r4,#36]
 cmp r0,#0
 beq no_slot
 PTR r0,ready_label
 bl show_label
 b loop
no_slot:
 PTR r0,no_slot_label
 bl show_label
loop:
 mov r0,#100
 CALL 0xC03705D8
 ldr r0,[r4,#36]
 cmp r0,#0
 beq loop
 bl poll_directions
 ldr r0,[r4,#260]
 cmp r0,#0
 subne r0,r0,#1
 str r0,[r4,#260]
 ldr r5,[r4,#8]
 ldr r0,[r4,#12]
 cmp r5,r0
 beq refresh_tick
 ldr r0,[r4,#228]
 cmp r0,#0
 beq attempt_apply
 cmp r5,r10
 bne attempt_apply
 sub r0,r0,#1
 str r0,[r4,#228]
 b loop
attempt_apply:
 mov r10,r5
 /* Invalidate before any write: cancellation must restore a partial batch. */
 mvn r0,#0
 str r0,[r4,#12]
 mov r0,r4
 mov r1,r5
 bl apply_checked
 cmp r0,#1
 beq applied_verified
 mov r0,#4 /* four skipped polls: retry at most every 500ms */
 str r0,[r4,#228]
 b loop
applied_verified:
 mov r0,#0
 str r0,[r4,#228]
 ldr r0,[r4,#8]
 cmp r0,r5
 bne loop
 str r5,[r4,#12]
 mov r0,#30
 str r0,[r4,#260]
 mov r0,#0
 str r0,[r4,#256]
 mov r0,r5
 bl show_recipe
 b loop
refresh_tick:
 ldr r0,[r4,#256]
 add r0,r0,#1
 str r0,[r4,#256]
 cmp r0,#10
 blt loop
 mov r0,#0
 str r0,[r4,#256]
 mov r0,r5
 bl show_recipe
 b loop
/* C02DCE78 writes this raw GPIO mask before OEM event filtering.
 * Physical masks from C2F1D024 table: AEL4, R100,L200,U80,D40.
 * Only rising direction edges while physical AEL is held queue recipes. */
poll_directions:
 push {r4-r8,lr}
 PTR r4,state
 movw r0,#0x575c
 movt r0,#0xc342
 ldr r5,[r0]
 ldr r6,[r4,#252]
 str r5,[r4,#252]
 cmp r5,r6
 beq raw_unchanged
 ldr r0,[r4,#224]
 add r0,r0,#1
 str r0,[r4,#224]
raw_unchanged:
 bic r6,r5,r6
 tst r5,#4
 beq poll_done
 mov r1,#0
 tst r6,#0x100
 movne r1,#0xc
 tst r6,#0x200
 movne r1,#0x10
 tst r6,#0x80
 movne r1,#0x14
 tst r6,#0x40
 movne r1,#0x18
 cmp r1,#0
 beq poll_done
 mov r0,#1
 str r0,[r4,#4]
 mov r0,r4
 bl navigation
poll_done:
 pop {r4-r8,pc}
/* r0 state, r1 ID. Setter order is explicit; all mode-specific snapshots
 * restored, not just the last recipe. WB snapshot lazily before first write. */
apply:
 push {r4-r10,lr}
 mov r4,r0
 mov r10,#1
 cmp r1,#RECIPE_COUNT
 movhi r10,#0
 bhi apply_done
 cmp r1,#0
 beq restore
 PTR r5,values
 sub r1,r1,#1
 mov r2,#96
 mla r5,r1,r2,r5
 ldr r7,[r5,#12]
 mov r1,r7
 ldr r0,[r4,#16]
 mov r2,#1
 CALL 0xC005C958
 /* Mode enum 12=OFF has no writable slot: 13/14/15 map to 12/13/14.
  * Verified from fp 5.02 C00B8240 switch and actual firmware emulation.
  * Restoration already iterates slots directly and must not be converted. */
 cmp r7,#12
 subhi r7,r7,#1
 mov r6,#1 /* catalog UI steps need x2 firmware signed-byte encoding */
 bl write_color
 ldr r1,[r5,#16]
 mov r8,#0
 cmp r1,#70
 moveq r8,#1
 ldr r0,[r4,#16]
 mov r2,#1
 CALL 0xC005C648
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r5,#16]
 cmp r0,r1
 bne apply_pending
 mov r9,#1
 lsl r9,r9,r8
 ldr r0,[r4,#32]
 tst r0,r9
 bne wb_saved
 add r6,r4,#232
 add r6,r6,r8,lsl #3
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_ba_raw
 str r0,[r6]
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_gm_raw
 str r0,[r6,#4]
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r5,#16]
 cmp r0,r1
 bne apply_pending
 ldr r0,[r4,#32]
 orr r0,r0,r9
 str r0,[r4,#32]
wb_saved:
 cmp r8,#1
 bne wb_offsets
 ldr r0,[r4,#16]
 ldr r1,[r5,#20]
 mov r2,#1
 CALL 0xC005C6E0
wb_offsets:
 ldr r1,[r5,#24]
 ldr r2,[r5,#28]
 bl write_wb
 b apply_done
restore:
 mov r7,#0
 mov r6,#0 /* snapshots are raw firmware integers; restore without scaling */
 add r5,r4,#40
restore_color:
 bl write_color
 add r5,r5,#12
 add r7,r7,#1
 cmp r7,#15
 blt restore_color
 mov r8,#0
restore_wb:
 mov r9,#1
 lsl r9,r9,r8
 ldr r0,[r4,#32]
 tst r0,r9
 beq next_wb
 ldr r0,[r4,#16]
 mov r1,#41
 cmp r8,#1
 moveq r1,#70
 mov r2,#1
 CALL 0xC005C648
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 mov r1,#41
 cmp r8,#1
 moveq r1,#70
 cmp r0,r1
 bne restore_wb_pending
 add r6,r4,#232
 add r6,r6,r8,lsl #3
 ldr r1,[r6]
 ldr r2,[r6,#4]
 bl write_wb
 bl verify_wb_snapshot
 cmp r0,#1
 beq next_wb
restore_wb_pending:
 mov r10,#0
next_wb:
 add r8,r8,#1
 cmp r8,#2
 blt restore_wb
 ldr r0,[r4,#16]
 ldr r1,[r4,#28]
 mov r2,#1
 CALL 0xC005C6E0
 ldr r0,[r4,#16]
 ldr r1,[r4,#24]
 mov r2,#1
 CALL 0xC005C648
 ldr r0,[r4,#16]
 ldr r1,[r4,#20]
 mov r2,#1
 CALL 0xC005C958
apply_done:
 mov r0,r10
 pop {r4-r10,pc}
apply_pending:
 mov r10,#0
 b apply_done
/* r0=state,r1=ID. 1 only after complete readback; 0 remains pending. */
apply_checked:
 push {r4-r10,lr}
 mov r4,r0
 mov r9,r1
 bl apply
 cmp r0,#1
 bne checked_done
 cmp r9,#0
 beq checked_restore
 PTR r5,values
 sub r0,r9,#1
 mov r1,#96
 mla r5,r0,r1,r5
 ldr r0,[r4,#16]
 CALL 0xC005C990
 ldr r1,[r5,#12]
 cmp r0,r1
 bne checked_fail
 ldr r7,[r5,#12]
 cmp r7,#12
 subhi r7,r7,#1
 mov r6,#1
 bl verify_color
 cmp r0,#1
 bne checked_done
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r5,#16]
 cmp r0,r1
 bne checked_fail
 cmp r1,#70
 bne checked_offsets
 ldr r0,[r4,#16]
 bl get_kelvin_raw
 ldr r1,[r5,#20]
 cmp r0,r1
 bne checked_fail
checked_offsets:
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_ba_raw
 ldr r1,[r5,#24]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_gm_raw
 ldr r1,[r5,#28]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r5,#16]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 CALL 0xC005C990
 ldr r1,[r5,#12]
 cmp r0,r1
 bne checked_fail
 b checked_success
checked_restore:
 mov r7,#0
 mov r6,#0
 add r5,r4,#40
checked_restore_color:
 bl verify_color
 cmp r0,#1
 bne checked_done
 add r5,r5,#12
 add r7,r7,#1
 cmp r7,#15
 blo checked_restore_color
 ldr r0,[r4,#16]
 CALL 0xC005C990
 ldr r1,[r4,#20]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r4,#24]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 bl get_kelvin_raw
 ldr r1,[r4,#28]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 ldr r1,[r4,#24]
 cmp r0,r1
 bne checked_fail
 ldr r0,[r4,#16]
 CALL 0xC005C990
 ldr r1,[r4,#20]
 cmp r0,r1
 bne checked_fail
checked_success:
 mov r0,#1
 b checked_done
checked_fail:
 mov r0,#0
checked_done:
 pop {r4-r10,pc}
/* Implicit r4 state,r5 three values,r6 UI-scale flag,r7 native slot. */
verify_color:
 push {r5-r9,lr}
 ldr r0,[r4,#16]
 mov r1,r7
 CALL 0xC005CAD0
 ldr r9,[r5]
 cmp r6,#0
 lslne r9,r9,#1
 cmp r0,r9
 bne verify_color_fail
 ldr r0,[r4,#16]
 mov r1,r7
 CALL 0xC005CB70
 ldr r9,[r5,#4]
 cmp r6,#0
 lslne r9,r9,#1
 cmp r0,r9
 bne verify_color_fail
 ldr r0,[r4,#16]
 mov r1,r7
 CALL 0xC005CC10
 ldr r9,[r5,#8]
 cmp r6,#0
 lslne r9,r9,#1
 cmp r0,r9
 bne verify_color_fail
 mov r8,#0
 cmp r6,#0
 addeq r8,r4,#264
 addeq r8,r8,r7,lsl #3
 ldr r0,[r4,#16]
 mov r1,r7
 bl get_effect_raw
 mov r9,#0
 cmp r8,#0
 ldrne r9,[r8]
 cmp r0,r9
 bne verify_color_fail
 ldr r0,[r4,#16]
 mov r1,r7
 CALL 0xC005CCB0
 mov r9,#0
 cmp r8,#0
 ldrne r9,[r8,#4]
 bne verify_toning_expected
 /* Source style 14 is the single Sepia recipe; candidate OEM Toning 7. */
 ldr r9,[r5,#36]
 cmp r9,#14
 moveq r9,#7
 movne r9,#0
verify_toning_expected:
 cmp r0,r9
 bne verify_color_fail
 mov r0,#1
 b verify_color_done
verify_color_fail:
 mov r0,#0
verify_color_done:
 pop {r5-r9,pc}
/* Restore bank verification while its mode is selected; no guessed slots. */
verify_wb_snapshot:
 push {r5,lr}
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 mov r5,#41
 cmp r8,#1
 moveq r5,#70
 cmp r0,r5
 bne verify_wb_fail
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_ba_raw
 ldr r1,[r6]
 cmp r0,r1
 bne verify_wb_fail
 ldr r0,[r4,#16]
 movw r1,#0xffff
 bl get_gm_raw
 ldr r1,[r6,#4]
 cmp r0,r1
 bne verify_wb_fail
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 cmp r0,r5
 bne verify_wb_fail
 mov r0,#1
 b verify_wb_done
verify_wb_fail:
 mov r0,#0
verify_wb_done:
 pop {r5,pc}
write_color:
 push {r6,lr}
 ldr r0,[r4,#16]
 ldr r1,[r5]
 cmp r6,#0
 lslne r1,r1,#1
 mov r2,r7
 mov r3,#1
 CALL 0xC005CA90
 ldr r0,[r4,#16]
 ldr r1,[r5,#4]
 cmp r6,#0
 lslne r1,r1,#1
 mov r2,r7
 mov r3,#1
 CALL 0xC005CB30
 ldr r0,[r4,#16]
 ldr r1,[r5,#8]
 cmp r6,#0
 lslne r1,r1,#1
 mov r2,r7
 mov r3,#1
 CALL 0xC005CBD0
 /* Explicit neutral Effect/Toning baseline prevents prior OEM settings
  * from tinting a recipe. Restore uses separately saved raw values. */
 cmp r6,#0
 bne aux_defaults
 add r6,r4,#264
 add r6,r6,r7,lsl #3
 ldr r1,[r6]
 ldr r6,[r6,#4]
 b aux_write
aux_defaults:
 mov r1,#0
 /* Original Sony style is preserved in the catalog record at +36. */
 ldr r6,[r5,#36]
 cmp r6,#14
 moveq r6,#7
 movne r6,#0
aux_write:
 ldr r0,[r4,#16]
 mov r2,r7
 mov r3,#1
 CALL 0xC005C9F0
 ldr r0,[r4,#16]
 mov r1,r6
 mov r2,r7
 mov r3,#1
 CALL 0xC005CC70
 pop {r6,pc}
/* Public Effect getter normalizes to zero when Mono Toning=B/W. Read the
 * original signed byte through the exact property-0x78 storage resolver so
 * even a currently hidden effect setting survives baseline application. */
get_effect_raw:
 push {r4,lr}
 mov r4,r1
 ldr r1,[r0]
 mov r0,r4
 CALL 0xC00B5FE0
 ldrsb r0,[r0]
 pop {r4,pc}
/* BA/GM public getters suppress stored offsets in monochrome modes.
 * Use the original property factory/count/selector/storage virtual interfaces.
 * r0 device, r1 selector; returned word preserves hidden signed offsets. */
get_ba_raw:
 mov r2,#0x1d0
 b get_offset_raw
get_gm_raw:
 mov r2,#0x1d4
get_offset_raw:
 push {r4-r6,lr}
 mov r4,r0
 mov r6,r2
 movw r3,#0xffff
 cmp r1,r3
 bne offset_index_ready
 bl get_wb_mode_raw
 CALL 0xC00B4938
 mov r1,r0
 mov r0,r4
offset_index_ready:
 mov r2,r6
 bl get_wb_raw
 pop {r4-r6,pc}
get_kelvin_raw:
 movw r1,#0xffff
 mov r2,#0x1cc
 b get_wb_raw
get_wb_mode_raw:
 movw r1,#0xffff
 mov r2,#0x1c8
get_wb_raw:
 push {r4-r8,lr}
 mov r5,r1
 ldr r0,[r0]
 ldr r3,[r0,#4]
 ldr r3,[r3,r2]
 blx r3
 mov r4,r0
 ldr r3,[r4,#12]
 ldr r3,[r3,#0x1c]
 blx r3
 mov r2,r0
 mov r0,r4
 mov r1,r5
 mov r3,#0x80000000
 add r3,r3,#1
 CALL 0xC00913F8
 mov r1,r0
 mov r0,r4
 ldr r3,[r4,#12]
 ldr r3,[r3,#0x18]
 blx r3
 ldr r0,[r0]
 pop {r4-r8,pc}
write_wb:
 push {r5-r9,lr}
 mov r5,r1
 mov r6,r2
 ldr r0,[r4,#16]
 bl get_wb_mode_raw
 CALL 0xC00B4938
 mov r7,r0
 ldr r0,[r4,#16]
 mov r1,r5
 mov r2,r7
 mov r3,#1
 CALL 0xC005C778
 ldr r0,[r4,#16]
 mov r1,r6
 mov r2,r7
 mov r3,#1
 CALL 0xC005C818
 pop {r5-r9,pc}
/* Own rectangle uses the same firmware surface/text ABI as C03E4620.
 * Clear ONLY our 768x32 band. Whole-layer clear erases OEM icons. */
show_label:
 push {r4-r8,lr}
 mov r5,r0
 mov r6,#3
hud_frame:
 mov r0,r5
 bl draw_text
 subs r6,r6,#1
 bne hud_frame
 pop {r4-r8,pc}
show_recipe:
 push {r4-r8,lr}
 cmp r0,#0
 bne hud_recipe
 PTR r0,restore_label
 b hud_label
hud_recipe:
 PTR r5,values
 sub r0,r0,#1
 mov r1,#96
 mla r4,r0,r1,r5
 ldr r0,[r4,#88]
 add r0,r5,r0
hud_label:
 bl show_label
 pop {r4-r8,pc}
draw_text:
 push {r4-r10,lr}
 sub sp,sp,#64
 mov r4,r0
 CALL 0xC0698D80
 ldr r3,[r0,#4]
 ldr r3,[r3,#12]
 mov r1,#1
 blx r3
 mov r7,r0
 ldr r3,[r7]
 ldr r3,[r3,#12]
 blx r3
 mov r1,r0
 add r0,sp,#32
 CALL 0xC0529BD8
 mov r0,#120
 str r0,[sp,#16]
 mov r0,#112
 str r0,[sp,#20]
 mov r0,#768
 str r0,[sp,#24]
 mov r0,#64
 str r0,[sp,#28]
 add r0,sp,#32
 add r1,sp,#16
 mov r2,#0
 CALL 0xC0529D98
 mov r6,#120
unicode_next:
 ldrb r8,[r4],#1
 cmp r8,#0
 beq unicode_done
 cmp r8,#10
 beq unicode_newline
 cmp r8,#128
 blo glyph_find
 cmp r8,#224
 blo unicode_two
 and r8,r8,#15
 ldrb r0,[r4],#1
 and r0,r0,#63
 orr r8,r0,r8,lsl #6
 ldrb r0,[r4],#1
 and r0,r0,#63
 orr r8,r0,r8,lsl #6
 b glyph_find
unicode_two:
 and r8,r8,#31
 ldrb r0,[r4],#1
 and r0,r0,#63
 orr r8,r0,r8,lsl #6
unicode_newline:
 cmp r8,#10
 bne glyph_find
 PTR r0,state
 ldr r0,[r0,#260]
 cmp r0,#0
 beq unicode_done
 mov r6,#120
 mov r0,#144
 str r0,[sp,#20]
 b unicode_next
glyph_find:
 PTR r9,hud_glyphs
 mov r10,#HUD_GLYPH_COUNT
glyph_scan:
 ldr r0,[r9]
 cmp r0,r8
 beq glyph_draw
 add r9,r9,#200
 subs r10,r10,#1
 bne glyph_scan
 b unicode_next
glyph_draw:
 ldr r10,[r9,#4]
 add r0,r6,r10
 cmp r0,#888
 bhi unicode_done
 str r6,[sp,#16]
 str r10,[sp,#24]
 mov r0,#32
 str r0,[sp,#28]
 PTR r1,hud_font
 strh r10,[r1,#2]
 add r0,r9,#8
 str r0,[r1,#12]
 PTR r0,hud_black
 str r0,[sp]
 add r0,sp,#32
 add r2,sp,#16
 mov r3,#39
 CALL 0xC052B550
 PTR r1,hud_font
 add r0,r9,#104
 str r0,[r1,#12]
 PTR r0,hud_white
 str r0,[sp]
 add r0,sp,#32
 add r2,sp,#16
 mov r3,#39
 CALL 0xC052B550
 add r6,r6,r10
 b unicode_next
unicode_done:
 PTR r0,no_output
 str r0,[sp]
 PTR r0,one
 str r0,[sp,#4]
 mov r0,sp
 mov r1,#1
 add r2,sp,#4
 CALL 0xC03E3D00
 add sp,sp,#64
 pop {r4-r10,pc}
no_output: mov r0,#0
 bx lr
ready_label: .asciz "准备就绪"
no_slot_label: .asciz "按键监听失败"
task_error_label: .asciz "任务启动失败"
restore_label: .asciz "原始设置"
one: .asciz "1"
.align 2
vtable: .word 0,0,0,0
state: .space 384 /* existing fields and Effect/Toning raw snapshots */
 .word 0 /* FILMLAB_MENU_OWNER: serial menu/input coordination */
 .word FILMLAB_STATE_ABI
state_end:
 .if (state_end-state) != FILMLAB_STATE_BYTES
 .error "resident state size disagrees with state-abi.inc"
 .endif
 .align 2

hud_font:
 .byte 39,39
 .hword 24,32,3,96
 .byte 1,0
 .word 0
hud_black: .word 0xffff0000
hud_white: .word 0xffffffff
hud_glyphs:
.incbin "native/data/hud-font.bin"
.align 2
values:
.incbin "native/data/film-catalog.bin"
