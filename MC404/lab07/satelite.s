.globl _start

calculo:
    # Inicialização de variável
    li t4, 3
    # Tempo de demora de cada mensagem
    sub s8, s7, s8
    sub s9, s7, s9
    sub s10, s7, s10
    # Distancia do satélite
    mul s8, s8, t4
    mul s9, s9, t4
    mul s10, s10, t4
    li t4, 10
    div s8, s8, t4
    div s9, s9, t4
    div s10, s10, t4
    # Calculo de Y
    mul s8, s8, s8
    mul t4, s6, s6
    mul s9, s9, s9
    sub s7, t4, s9
    add s7, s7, s8
    div s7, s7, s6
    li t4, 2
    div s7, s7, t4
    # Calculo de X
    mul t4, s5, s5
    mul s10, s10, s10
    sub s6, s8, s10
    add s6, s6, t4
    div s6, s6, s5
    li t4, 2
    div s6, s6, t4
    ret

coordenada:
    # Código para ajustar ponteiros
    addi sp,sp,-4
    sw ra, 0(sp)

    # Código aqui
    jal ra, read
    la s0, input_address

    li t0, 10
    li t2, 0
    li s4, 0
    li s7, 1
    li s8, 2
    li s9, 3
    li s10, 4
    li s11, 0
    li a2, 4
    li a6, -1
    
    # Pega 4 digitos e transforma em inteiro através de soma e multiplicação sucessiva
    for2:
        # Inicializando s2 com 0 e criando a temporária
        li s2, 0
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0 
        # Atualiza t2
        addi t2, t2, 1
        # Subtrai 48 do algarismo pra transformar em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 2 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1
        
        # Realiza operação de raiz quadrada e conversão em ascii
        addi s4, s4, 1
        beq s4, s7, inst1
        beq s4, s8, inst2
        beq s4, s9, inst3
        beq s4, s10, inst4
        inst1:
            mv s7, s2
            j for2
        inst2:
            mv s8, s2
            j for2
        inst3:
            mv s9, s2
            j for2
        inst4:
            mv s10, s2
        jal ra, calculo
    lw ra,0(sp)
    addi sp, sp, 4
    ret
    
convert:
    # Converte o número em ascii e salva em result
    # Inicializa
    li a2, 32
    li a3, 10
    li a4, 0
    li t5, -1
    # 1 identificar se é negativo X (s6)
    blt s6, a4, neg
    # 1.1 Adicionar sinal ao result
    li t3, 43
    sb t3, 0(s1)
    j cont
    neg:
        li t3, 45
        sb t3, 0(s1)
        mul s6, s6, t5
    cont:
    # 1.2 Adicionar números ao result
        # Conversão 1
        rem t3, s6, a3
        addi t3, t3, 48
        div s6, s6, a3
        # Colocando dentro do buffer 1
        sb t3, 4(s1)
        # Conversão 2
        rem t3, s6, a3
        addi t3, t3, 48
        div s6, s6, a3
        # Colocando dentro do buffer 2
        sb t3, 3(s1)
        # Conversão 3
        rem t3, s6, a3
        addi t3, t3, 48
        div s6, s6, a3
        # Colocando dentro do buffer 3
        sb t3, 2(s1)
        # Conversão 4
        rem t3, s6, a3
        addi t3, t3, 48
        div s6, s6, a3
        # Colocando dentro do buffer 4
        sb t3, 1(s1)
    # ___ Adiciona espaço ___
        sb a2, 5(s1)
    # 2 identificar se é negativo Y (s7)
    blt s7, a4, neg2
    # 1.1 Adicionar sinal ao result
    li t3, 43
    sb t3, 6(s1)
    j cont2
    neg2:
        li t3, 45
        sb t3, 6(s1)
        mul s7, s7, t5
    cont2:
    # 1.2 Adicionar números ao result
        # Conversão 1
        rem t3, s7, a3
        addi t3, t3, 48
        div s7, s7, a3
        # Colocando dentro do buffer 1
        sb t3, 10(s1)
        # Conversão 2
        rem t3, s7, a3
        addi t3, t3, 48
        div s7, s7, a3
        # Colocando dentro do buffer 2
        sb t3, 9(s1)
        # Conversão 3
        rem t3, s7, a3
        addi t3, t3, 48
        div s7, s7, a3
        # Colocando dentro do buffer 3
        sb t3, 8(s1)
        # Conversão 4
        rem t3, s7, a3
        addi t3, t3, 48
        div s7, s7, a3
        # Colocando dentro do buffer 4
        sb t3, 7(s1)
    # ___ Adiciona \n ___
    sb a3, 11(s1)
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
    jal ra, read2
    la s0, input_address
    la s1, result

    li t0, 10
    li t2, 0
    li t3, 45
    li s4, 0
    li s11, 0
    li a2, 2
    li a6, -1
    
    # Pega 4 digitos e transforma em inteiro através de soma e multiplicação sucessiva
    for:
        # Manipulando o sinal
        li s2, 0
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0 
        # Atualiza t2
        addi t2, t2, 1
        # Verifica o sinal
        beq t1, t3, menos
        li t4, 1
        j continuacao
        menos:
            li t4, -1
        continuacao:
        # Inicializando s2 com 0 e criando a temporária
        li s2, 0
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0 
        # Atualiza t2
        addi t2, t2, 1
        # Subtrai 48 do algarismo pra transformar em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 1 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1

        # Inicializando a temporária
        add s11, s0, t2
        lb t1, 0(s11)
        li s11, 0
        # Atualiza t2
        addi t2, t2, 2 
        # Subtrai 48 do algarismo pra transforma em inteiro e guarda
        addi t1, t1, -48
        # Multiplica y por 10
        mul s2, s2, t0
        # Soma os dois números e guarda em y
        add s2, s2, t1
        # Insere sinal
        mul s2, s2, t4
        
        # Salva as entradas
        bnez s4, vai
        mv s5, s2 # !!!
        vai:
        addi s4, s4, 1
        # Volta pro for se s4 < 2
        bltu s4, a2, for
        mv s6, s2 # !!!
        jal ra, coordenada
        jal ra, convert
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

read2:
    li a0, 0            # file descriptor = 0 (stdin)
    la a1, input_address # buffer
    li a2, 12           # size - Reads 20 bytes.
    li a7, 63           # syscall read (63)
    ecall
    ret

write:
    li a0, 1            # file descriptor = 1 (stdout)
    la a1, result       # buffer
    li a2, 12           # size - Writes 12 bytes.
    li a7, 64           # syscall write (64)
    ecall
    ret

.bss

input_address: .skip 0x20  # buffer

result: .skip 0x12
