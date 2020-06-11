
OUTPUT_ARCH(riscv)
ENTRY(_start)

BASE_ADDRESS = 0x80200000;

/**
 *
 * 使用链接脚本指定程序内存布局
 * 对于普通用户程序来说，数据是放在低地址空间上的。
 * 但是对于 OS 内核，它一般都在高地址空间上。
 * 并且在 RISCV 中，内存（RAM）的物理地址也是从 0x80000000 开始的。
 * 因此接下来我们需要调整程序的内存布局，改变它的链接地址。
 *  程序的内存布局
 *  一般来说，一个程序按照功能不同会分为下面这些段：
 *  .text 段，即代码段，存放汇编代码；
 *  .rodata 段，即只读数据段，顾名思义里面存放只读数据，通常是程序中的常量；
 *  .data 段，存放被初始化的可读写数据，通常保存程序中的全局变量；
 *  .bss 段，存放被初始化为 000 的可读写数据，与 .data 段的不同之处在于我们知道它要被初始化为 000 ，因此在可执行文件中只需记录这个段的大小以及所在位置即可，而不用记录里面的数据。
 *  stack ，即栈，用来存储程序运行过程中的局部变量，以及负责函数调用时的各种机制。它从高地址向低地址增长；
 *  heap ，即堆，用来支持程序运行过程中内存的动态分配，比如说你要读进来一个字符串，在你写程序的时候你也不知道它的长度究竟为多少，于是你只能在运行过程中，知道了字符串的长度之后，再在堆中给这个字符串分配内存。
 *
 */
SECTIONS
{
    /* Load the kernel at this address: "." means the current address */
    . = BASE_ADDRESS;
    start = .;

    .text : {
        stext = .;
        *(.text.entry)
        *(.text .text.*)
        . = ALIGN(4K);
        etext = .;
    }

    .rodata : {
        srodata = .;
        *(.rodata .rodata.*)
        . = ALIGN(4K);
        erodata = .;
    }

    .data : {
        sdata = .;
        *(.data .data.*)
        edata = .;
    }

    .stack : {
        *(.bss.stack)
    }

    .bss : {
        sbss = .;
        *(.bss .bss.*)
        ebss = .;
    }

    PROVIDE(end = .);
}
