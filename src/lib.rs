#![no_std] // don't link the Rust standard library
#![feature(asm)]
#![feature(global_asm)]

// src/lib.rs
#[macro_use]
mod io;

mod init;

mod lang_items;

mod sbi;
