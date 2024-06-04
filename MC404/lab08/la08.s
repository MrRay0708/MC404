_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall

main:
    
open:
    la a0, input_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open 
    ecall

    input_file: .asciz "image.pgm"

setCanvasSize:
    lb a0, s2           # largura 
    lb a1, s3           # altura 
    lb a7, 2201         # syscall setCanvasSize (2201)
    ecall
    
setPixel:
    lb a0, s2           # x coordinate 
    lb a1, s3           # y coordinate 
    lb a2, s4           # cor do pixel
    li a7, 2200         # syscall setPixel (2200)
    ecall

read:
    li a0, 0             # file descriptor = 0 (stdin)
    la a1, input_address # buffer
    li a2, 262159        # size - Reads 262159 bytes.
    li a7, 63            # syscall read (63)
    ecall
    ret

write:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, result       # buffer
    li a2, 262159       # size - Writes 262159 bytes.
    li a7, 64           # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x262159  # buffer

result: .skip 0x262159 # buffer