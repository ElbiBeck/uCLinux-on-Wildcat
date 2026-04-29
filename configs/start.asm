.section .text.start, "ax"
.global _start
_start:
    # Set up stack
    la      sp, _stack_top

    # a0 = hartid (hart 0)
    li      a0, 0

    # a1 = pointer to DTB
    la      a1, _dtb

    # Jump to Linux kernel entry point
    la      t0, _payload
    jr      t0

.section .dtb, "a"
.balign 4
_dtb:
.incbin "wildcat.dtb"

.section .payload, "ax"
.balign 4
_payload:
.incbin "Image"

.section .bss
.balign 16
.space 4096
_stack_top:
