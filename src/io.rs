// src/io.rs
use crate::sbi::console_putchar;
use core::fmt::{self, Write};

pub fn putchar(ch: char) {
    console_putchar(ch as u8 as usize)
}

pub fn putstr(s: &str) {
    for ch in s.chars() {
        putchar(ch)
    }
}

struct Stdout;
impl fmt::Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        putstr(s);
        Ok(())
    }
}

pub fn _print(args: fmt::Arguments) {
    Stdout.write_fmt(args).unwrap();
}

#[macro_export]
macro_rules! println {
    () => ($crate::print!("\n"));
    ($($arg:tt)*) => ($crate::print!("{}\n", format_args!($($arg)*)));
}

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => ({
        $crate::io::_print(format_args!($($arg)*));
    });
}
