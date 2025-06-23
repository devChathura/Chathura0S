#!/bin/bash
nasm -f bin bootload.asm -o boot.bin
nasm -f bin kernel.asm -o kernel.bin
cat boot.bin kernel.bin > chathuraos.img
qemu-system-x86_64 -fda chathuraos.img