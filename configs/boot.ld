OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text.start : { *(.text.start) }

    . = ALIGN(8);
    .dtb : { *(.dtb) }

    . = 0x80001000;
    .payload : { *(.payload) }

    .bss (NOLOAD) : { *(.bss) }
}