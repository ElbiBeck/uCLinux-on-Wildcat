OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text.start : { *(.text.start) }

    . = ALIGN(0x1000);
    .dtb        : { *(.dtb) }

    . = ALIGN(0x1000);
    .payload    : { *(.payload) }

    .bss : { *(.bss) }
}