OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text.start : { *(.text.start) }

    . = ALIGN(16);
    .dtb : { *(.dtb) }

    /* Image MUST start exactly at CONFIG_PHYS_RAM_BASE */
    . = 0x80400000;
    .payload : { *(.payload) }

    .bss (NOLOAD) : { *(.bss) }
}