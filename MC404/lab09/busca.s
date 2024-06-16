_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall

main:
    # recebe o número
    # vai em data.s
    # percorre lista somando, caso seja diferente, vai pro próximo (provavelmente usa só skip)
    # devolve o nodo certo

read:
    li a0, 0            # file descriptor = 0 (stdin)
    la a1, input_address # buffer
    li a2, 32           # size - Reads 32 bytes.
    li a7, 63           # syscall read (63)
    ecall
    ret

write:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, result       # buffer
    li a2, 32           # size - Writes 32 bytes.
    li a7, 64           # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x20  # buffer

result: .skip 0x12