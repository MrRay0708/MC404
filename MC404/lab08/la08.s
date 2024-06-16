.globl _start

_start:
    jal main
    li a0, 0
    li a7, 93               # exit
    ecall

open:
    la a0, input_file       # address for the file path
    li a1, 0                # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0                # mode
    li a7, 1024             # syscall open 
    ecall
    ret

    input_file: .asciz "image.pgm"

setCanvasSize:
    mv a0, a3               # largura 
    mv a1, a4               # altura 
    li a7, 2201             # syscall setCanvasSize (2201)
    ecall
    ret
    
setPixel:
    mv a0, s6               # x coordinate 
    mv a1, s7               # y coordinate 
    mv a2, s4               # cor do pixel
    li a7, 2200             # syscall setPixel (2200)
    ecall
    ret

main:
    # Código para ajustar ponteiros
    addi sp,sp,-4
    sw ra, 0(sp)

    jal ra, open
    mv s0, a0               # armazena input_file em s0

    jal ra, read 
    la s1, input_address

    # até 1º '\n' ignora ; pega largura até ' ' ; pega altura até 2º '\n' ; armazena 255 em s2 e ignora até 3º '\n' ; pega vetor de pixels até 4º '\n'
    li t0, 0
    li t1, 10
    li t2, 32
    li a3, 0
    li a4, 0

    for: # pronto
        # Pega byte
        add s11, s1, t0
        lb t3, 0(s11)
        li s11, 0
        # Atualiza t0
        addi t0, t0, 1
        # Compara
        beq t3, t1, for2
        j for

    for2:
        # Pega byte
        add s11, s1, t0
        lb t3, 0(s11)
        li s11, 0 
        # Atualiza t0
        addi t0, t0, 1
        # Compara
        beq t3, t2, for3
        # Largura
        addi t3, t3, -48
        mul a3, a3, t1
        add a3, a3, t3
        j for2

    for3:
        # Pega byte
        add s11, s1, t0
        lb t3, 0(s11)
        li s11, 0 
        # Atualiza t0
        addi t0, t0, 1
        # Compara
        beq t3, t1, for4
        # Altura
        addi t3, t3, -48
        mul a4, a4, t1
        add a4, a4, t3
        j for3

    for4: # pronto
        # Transparencia
        li s5, 255
        # Pega byte
        add s11, s1, t0
        lb t3, 0(s11)
        li s11, 0 
        # Atualiza t0
        addi t0, t0, 1
        # Compara
        beq t3, t1, matriz
        j for4

    matriz:
        # constroi malha
        jal ra, setCanvasSize
        mv s10, t0
        addi s10, s10, 1
        li t1, 10
    for5:
        # Pega byte
        add s11, s1, t0
        lb s4, 0(s11)
        li s11, 0 
        # Atualiza t0
        addi t0, t0, 1
        # Compara
        beq s4, t1, end
        addi s4, s4, -48
        # Ajustar a cor do pixel
        slli t2, s4, 24         # Shiftar 24 bits à esquerda (Red)
        slli t3, s4, 16         # Shiftar 16 bits à esquerda (Green)
        slli t4, s4, 8          # Shiftar 8 bits à esquerda (Blue)
        or t2, t2, t3           # OR dos valores Red e Green
        or t2, t2, t4           # OR do resultado com Blue
        li t5, 255              # Alpha
        or t2, t2, t5           # OR do resultado com Alpha
        mv s4, t2

        # pega largura do pixel (resto da posição de indice pela largura) a3
        sub s9, t0, s10
        rem s6, s9, a3
        # pega altura do pixel (divisao da posição de indice pela largura) a4
        div s7, s9, a3
        # adiciona pixel na malha
        jal ra, setPixel
        j for5
    end:
        lw ra,0(sp)
        addi sp, sp, 4 
        ret


read:
    mv a0, s0                   # file descriptor = 0 (stdin)
    la a1, input_address        # buffer
    li a2, 262159               # size - Reads 262159 bytes.
    li a7, 63                   # syscall read (63)
    ecall
    ret

.bss

input_address: .skip 0x262159  # buffer
