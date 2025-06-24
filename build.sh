#!/bin/bash

echo "--- Assembling Bootloader ---"
nasm -f bin bootload.asm -o boot.bin

echo "--- Assembling Kernel ---"
nasm -f bin kernel.asm -o kernel.bin

echo "--- Combining to create disk image ---"
cat boot.bin kernel.bin > chathuraos.img

echo "--- Booting with QEMU ---"
qemu-system-x86_64 -fda chathuraos.img