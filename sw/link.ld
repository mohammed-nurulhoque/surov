SECTIONS
{
. = 0x0;
.text : { 
    *(.start)
    *(.text) 
}
.rodata : { *(.rodata*) }
.data : { *(.data) }
.bss : { *(.bss) }
}
