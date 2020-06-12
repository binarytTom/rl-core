#![no_std] // disable all Rust-level entry points
#![no_main] // disable all Rust-level entry points
#[allow(unused_imports)]
use rlcore;
// 在屏幕上输出一个字符，目前我们先不用了解其实现原理
// 使用了opensbi的系统调用
//pub fn console_putchar(ch: u8) {
//    let ret: usize;
//    let arg0: usize = ch as usize;
//    let arg1: usize = 0;
//    let arg2: usize = 0;
//    let which: usize = 1;
//    unsafe {
//        asm!("ecall"
//             : "={x10}" (ret)
//             : "{x10}" (arg0), "{x11}" (arg1), "{x12}" (arg2), "{x17}" (which)
//             : "memory"
//             : "volatile"
//        );
//    }
//}
