###################################################
# MC102 - Algoritmos e Programação de Computadores
# Laboratório 12 - Pac-Man I
# Nome: 
# RA: 
###################################################

# Leitura da entrada
N = int(input()) #linhas
T = int(input())

mapa = []
for _ in range(N):
    mapa.append(list(input()))

# Simulação do jogo

def direita (poder, pastilhas, tempo_restante):
    # confere se é uma letra especial 
    if (mapa[pY, pX + 1] == '*'):
        poder += 1
        tempo_restante += T
        mapa[pY, pX] = '0'
        mapa[pY, pX + 1] = 'C'
        pY = pY
        pX = + 1
    elif (mapa[pY, pX + 1] == 'X'):
        if (poder == 1):
            tempo_restante -= 1
            if (tempo_restante == 0):
                poder = 0
            mapa[pY, pX] = '0'
            mapa[pY, pX + 1] = 'C'
            pY = pY
            pX = + 1
        else:
            pass #morre
    else:
        if (mapa[pY, pX + 1] == '.'):
            pastilhas += 1
        if (poder == 1):
            tempo_restante -= 1
        if (tempo_restante == 0):
            poder = 0
        mapa[pY, pX] = '0'
        mapa[pY, pX + 1] = 'C'
        pY = pY
        pX = pX + 1
    # avança para frente

def cima (poder, pastilhas, tempo_restante):
    # confere se é uma letra especial
    if (mapa[pY - Colunas, pX] == '*'):
        poder += 1
        tempo_restante += T
        mapa[pY, pX] = '0'
        mapa[pY - Colunas, pX] = 'C'
        pY = pY - Colunas
        pX = pX
    elif (mapa[pY - Colunas, pX] == 'X'):
        if (poder == 1):
            tempo_restante -= 1
            if (tempo_restante == 0):
                poder = 0
            mapa[pY, pX] = '0'
            mapa[pY - Colunas, pX] = 'C'
            pY = pY - Colunas
            pX = pX
        else:
            pass #morre
    else:
        if (mapa[pY - Colunas, pX] == '.'):
            pastilhas += 1
        if (poder == 1):
            tempo_restante -= 1
        if (tempo_restante == 0):
            poder = 0
        mapa[pY, pX] = '0'
        mapa[pY - Colunas, pX] = 'C'
        pY = pY - Colunas
        pX = pX
    # vai pra cima

def esquerda (poder, pastilhas, tempo_restante):
    # confere se é uma letra especial
    if (mapa[pY, pX - 1] == '*'):
        poder += 1
        tempo_restante += T
        mapa[pY, pX] = '0'
        mapa[pY, pX - 1] = 'C'
        pY = pY
        pX = pX - 1
    elif (mapa[pY, pX - 1] == 'X'):
        if (poder == 1):
            tempo_restante -= 1
            if (tempo_restante == 0):
                poder = 0
            mapa[pY, pX] = '0'
            mapa[pY, pX - 1] = 'C'
            pY = pY
            pX = pX - 1
        else:
            pass #morre
    else:
        if (mapa[pY, pX - 1] == '.'):
            pastilhas += 1
        if (poder == 1):
            tempo_restante -= 1
        if (tempo_restante == 0):
            poder = 0
        mapa[pY, pX] = '0'
        mapa[pY, pX - 1] = 'C'
        pY = pY
        pX = pX - 1
    # avança para esquerda

def baixo (poder, pastilhas, tempo_restante):
    # confere se é uma letra especial
    if (mapa[pY + Colunas, pX] == '*'):
        poder += 1
        tempo_restante += T
        mapa[pY, pX] = '0'
        mapa[pY + Colunas, pX] = 'C'
        pY = pY + Colunas
        pX = pX
    elif (mapa[pY + Colunas, pX] == 'X'):
        if (poder == 1):
            tempo_restante -= 1
            if (tempo_restante == 0):
                poder = 0
            mapa[pY, pX] = '0'
            mapa[pY + Colunas, pX] = 'C'
            pY = pY + Colunas
            pX = pX
        else:
            pass #morre
    else:
        if (mapa[pY + Colunas, pX] == '.'):
            pastilhas += 1
        if (poder == 1):
            tempo_restante -= 1
        if (tempo_restante == 0):
            poder = 0
        mapa[pY, pX] = '0'
        mapa[pY + Colunas, pX] = 'C'
        pY = pY + Colunas
        pX = pX
    # avança para direita

Colunas = len(mapa) / N #colunas

j = 0
for i in mapa:
    if (i == 'C'):
        pY = j % N
        pX = j / N
        break
    j += 1

# Pac-man
pastilhas = 0
poder = 0
tempo_restante = 0

direção = 1
if (direção == 1): # olhando para direita
    if (mapa[pY + Colunas, pX] == '#'):
        if (mapa[pY, pX + 1] == '#'):
            if (mapa[pY - Colunas, pX] != '#'):
                cima(poder, pastilhas, tempo_restante)
            else:
                esquerda(poder, pastilhas, tempo_restante)
        else:
            direita(poder, pastilhas, tempo_restante)
    else:
        baixo(poder, pastilhas, tempo_restante)
    
elif (direção == 2): # olhando para cima
    if (mapa[pY, pX + 1] == '#'):
        if (mapa[pY - Colunas, pX] == '#'):
            if (mapa[pY, pX - 1] != '#'):
                esquerda(poder, pastilhas, tempo_restante)
            else:
                baixo(poder, pastilhas, tempo_restante)
        else:
            cima(poder, pastilhas, tempo_restante)
    else:
        direita(poder, pastilhas, tempo_restante)
        

elif (direção == 3): # olhando para esquerda
    if (mapa[pY - Colunas, pX] == '#'):
        if (mapa[pY, pX - 1] == '#'):
            if (mapa[pY + Colunas, pX] != '#'):
                baixo(poder, pastilhas, tempo_restante)
            else:
                direita(poder, pastilhas, tempo_restante)
        else:
            esquerda(poder, pastilhas, tempo_restante)
    else:
        cima(poder, pastilhas, tempo_restante)

else: # olhando para baixo
    if (mapa[pY, pX - 1] == '#'):
        if (mapa[pY + 1, pX] == '#'):
            if (mapa[pY, pX + 1] != '#'):
                direita(poder, pastilhas, tempo_restante)
            else:
                cima(poder, pastilhas, tempo_restante)
        else:
            baixo(poder, pastilhas, tempo_restante)
    else:
        esquerda(poder, pastilhas, tempo_restante)

# Impressão da saída