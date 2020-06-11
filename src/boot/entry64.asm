# src/boot/entry64.asm
#	

    .section .text.entry
    .globl _start
_start:
    # 修改栈指针寄存器sp 
    # .bss.satck 段的结束地址，由于栈是从高地址往低地址增长，所以高地址是栈顶
    la sp, bootstacktop
    call rust_main

    #在.bss.stack分配一块16Kb的内存作为内核的栈, 12位对齐
    .section .bss.stack
    .align 12
    .global bootstack
bootstack:
    .space 4096 * 4
    .global bootstacktop
bootstacktop:
