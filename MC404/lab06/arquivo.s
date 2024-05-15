.globl _start

raiz:
    # Lembrando, y=s2, k=s3, temporária=t3, y/k=t4
    # y/2 e salva no registrador
    li s3, 0 
    li a3, 2
    div s3, s2, a3
    
    # cria variável de contagem t3 e a2
    li t3, 0
    li a2, 10

    # Laço de s3' sendo renovado
        media:
        # Executa as operações necessárias
            # armazena y/k em t4
            div t4, s2, s3
            # soma t4 com s3 e armazena em t5
            add t5, t4, s3
            # s3 recebe a t5 / 2
            div s3, t5, a3
            # Atualiza t3
            addi t3, t3, 1
        # essa é instrução de laço para um valor t < 10 (bltu a0, a2, media)
        
        bltu t3, a2, media
    ret

convert:
    # Converte o número em ascii e salva em result
    li t6, 0
    li s10, 0
    li a2, 5
    li a3, 10
    mul t6, s5, a2
    addi t6, t6, -1
    # Insere o espaço
    add s10, s1, t6
    sb s6, 0(s10)
    li s10, 0 
    addi t6, t6, -1

    loop:
        # Conversão (s3 guarda a raiz) 
        rem s4, s3, a3
        addi s4, s4, 48
        div s3, s3, a3
        # Colocando dentro do buffer
        add s10, s1, t6
        sb s4, 0(s10)
        li s10, 0 
        addi t6, t6, -1
        # reinicia laço
        blt a6, t6, loop
    # Ajusta a6
    addi a6, a6, 5
    ret

_start:
    jal main
    li a0, 0
    li a7, 93 # exit
    ecall


main:
    # Código para ajustar ponteiros
    addi sp,sp,-4
    sw ra, 0(sp)

    # Código aqui
    jal ra, read
    la s0, input_address
    la s1, result

    li t0, 10
    li t2, 0
    li s5, 0
    li s6, 32
    li s9, 10
    li s10, 0
    li a2, 4
    li a6, -1
    
    # Pega 4 digitos e transforma em inteiro através de soma e multiplicação sucessiva
    for:
        # Inicializando s2 com 0 e criando a temporária
        li s2, 0
        add s10, s0, t2
        lbu t1, 0(s10)
        li s10, 0 
        # Atualiza t2
        addi t2, t2, 1
        # Subtrai 48 do algarismo pra transformar em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s10, s0, t2
        lbu t1, 0(s10)
        li s10, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s10, s0, t2
        lbu t1, 0(s10)
        li s10, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s10, s0, t2
        lbu t1, 0(s10)
        li s10, 0
        # Atualiza t2
        addi t2, t2, 2 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1
        
        # Realiza operação de raiz quadrada e conversão em ascii
        addi s5, s5, 1
        jal raiz
        jal convert
        # Volta pro for se t2 < 20
        bltu s5, a2, for
    
    sb s9, 19(s1)
    jal ra, write
    lw ra,0(sp)
    addi sp, sp, 4
    ret

read:
    li a0, 0            # file descriptor = 0 (stdin)
    la a1, input_address # buffer
    li a2, 20           # size - Reads 20 bytes.
    li a7, 63           # syscall read (63)
    ecall
    ret

write:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, result       # buffer
    li a2, 20           # size - Writes 20 bytes.
    li a7, 64           # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x20  # buffer

result: .skip 0x20