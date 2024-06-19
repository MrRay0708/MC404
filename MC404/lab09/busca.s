.globl _start

_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall

main:
    # recebe o número
    addi sp,sp,-4
    sw ra, 0(sp)

    jal ra, read
    la s1, input_address
    la s0, result
    li s2, 0
    li s3, 0
    li t5, 10
    li t6, 0
    li a3, 45
    li a4, 1

    # Verifica sinal 
    # Inicializando s2 com 0 e criando a temporária
    add s11, s1, t6
    lb t1, 0(s11)
    li s11, 0 
    # Atualiza t6
    addi t6, t6, 1
    # Olha se é menos
    beq t1, a3, menos
    # Subtrai 48 do algarismo pra transformar em inteiro e guarda
    addi t1, t1, -48
    # Multiplica y por 10
    mul s10, s10, t5
    # Soma os dois números e guarda em y
    add s10, s10, t1
    j convert
    menos:
    li a4, -1
    convert:
    # Inicializando s2 com 0 e criando a temporária
    add s11, s1, t6
    lb t1, 0(s11)
    li s11, 0 
    # Atualiza t6
    addi t6, t6, 1
    # Verificação
    beq t1, t5, continua
    # Subtrai 48 do algarismo pra transformar em inteiro e guarda
    addi t1, t1, -48
    # Multiplica y por 10
    mul s10, s10, t5
    # Soma os dois números e guarda em y
    add s10, s10, t1
    # Retorno
    j convert
    continua:
    mul s10, s10, a4
    li t6, 0

    # vai em data.s
    # percorre lista somando, caso seja diferente, vai pro próximo (provavelmente usa só skip)
    la s2, head_node
    loop:
    lw t1, 0(s2)
    lw t2, 4(s2)
    lw t3, 8(s2)
    mv t4, t1
    add t4, t4, t2 
    add t4, t4, t3
    beq t4, s10, achou
    addi s3, s3, 1
    lw t5, 12(s2)
    beq t5, t6, nao_tem
    mv s2, t5
    j loop

    nao_tem:
    li t6, 1
    sb a3, 0(s0)
    sb t6, 1(s0)
    sb t5, 2(s0)
    j encerra


    achou:
    # Inicializando e criando a variável temporária
    li t2, 0
    li s11, 0 
    # Conversão 
    rem t3, s3, t5
    addi t3, t3, 48
    div s3, s3, t5
    # Atualiza t6
    addi t6, t6, 1
    # Colocando dentro do buffer 
    sb t3, 0(s0)
    # Compara
    beq s3, t2, processamento
    srai s0, s0, 1
    j achou

    # devolve o nodo certo
    processamento:
    addi t6, t6, 1
    add s11, s0, t6
    li t6, 0
    sb t6, 0(s11)

    /* 
    li t5, 0

    inverte:
    li s11, 0 
    addi t6, t6, -1
    add s10, s4, t5
    add s11, s0, t6
    lb t3, 0(s10)
    sb t3, 0(s11)
    addi t5, t5, 1
    bnez t6, inverte
    li t5, 0
    sb t5, 1(s11)
    */

    encerra:
    jal ra, write

    lw ra,0(sp)
    addi sp, sp, 4 
    ret

read:
    li a0, 0                # file descriptor = 0 (stdin)
    la a1, input_address    # buffer
    li a2, 8                # size - Reads 32 bytes.
    li a7, 63               # syscall read (63)
    ecall
    ret

write:
    li a0, 1                # file descriptor = 1 (stdout)
    la a1, result           # buffer
    li a2, 8                # size - Writes 32 bytes.
    li a7, 64               # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x8 # buffer

result: .skip 0x8