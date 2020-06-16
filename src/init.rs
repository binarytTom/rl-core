// src/init.rs
global_asm!(include_str!("boot/entry64.asm"));

#[no_mangle]
extern "C" fn rust_main() -> ! {
    // 在屏幕上输出 "OK\n" ，随后进入死循环
    println!("starting");
    extern "C" {
        fn _start();
        fn bootstacktop();
    }
    println!("_start vaddr = 0x{:x}", _start as usize);
    println!("bootstacktop vaddr = 0x{:x}", bootstacktop as usize);
    println!("hello world!");
    panic!("you want to do nothing!");
    loop {}
}
