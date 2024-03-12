ola.s: ola.c
    clang-17 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax ola.c -S -o ola.s

ola.o: ola.s
    clang-17 --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax ola.s -c -o ola.o