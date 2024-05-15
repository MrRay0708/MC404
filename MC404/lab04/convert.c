int decimal_to_base(unsigned int decimal_num, int base, int tamanho, char* string){
    // Inicializando a string binária
    char bin_base[] = "01";
    string[tamanho - 1] = '\0';
    int index = tamanho - 2;

    // Convertendo decimal para binário
    while (decimal_num > 0 && index >= 0) {
        int resto = decimal_num % base;
        string[index] = bin_base[resto];
        decimal_num /= base;
        index--;
    }

    switch (tamanho)
    {
    case 33:
        string[index] = 'b';
    case 9:
        string[index] = 'x';
    case 12:
        string[index] = 'o';
    }
    string[index - 1] = '0';

    return 0;
}

char* decimal_to_binary(unsigned int decimal_num) {

    char bin_str[33]; // 32 bits + caractere nulo

    // Inicializando a string binária
    char bin_base[] = "01";
    bin_str[32] = '\0';
    int index = 31;

    // Convertendo decimal para binário
    while (decimal_num > 0 && index >= 0) {
        int resto = decimal_num % 16;
        bin_str[index] = bin_base[resto];
        decimal_num /= 16;
        index--;
    }
    bin_str[index] = 'b';
    bin_str[index - 1] = '0';

    return bin_str;
}

char* decimal_to_hexadecimal(unsigned int decimal_num) {
    // Alocando memória para armazenar o hexadecimal como string
    char hex_str[9]; // 8 bits + caractere nulo

    // Inicializando a string hexadecimal
    char hex_base[] = "0123456789ABCDEF";
    hex_str[8] = '\0';
    int index = 7;

    // Convertendo decimal para hexadecimal
    while (decimal_num > 0 && index >= 0) {
        int resto = decimal_num % 16;
        hex_str[index] = hex_base[resto];
        decimal_num /= 16;
        index--;
    }
    hex_str[index] = 'x';
    hex_str[index - 1] = '0';

    return hex_str;
}

char* decimal_to_octal(unsigned int decimal_num) {
    // Alocando memória para armazenar o octal como string
    char octal_str[12]; // 11 bits + caractere nulo

    // Inicializando a string octal
    char octal_base[] = "01234567";
    octal_str[11] = '\0';
    int index = 10;

    // Convertendo decimal para octal
    while (decimal_num > 0 && index >= 0) {
        int resto = decimal_num % 8;
        octal_str[index] = octal_base[resto];
        decimal_num /= 8;
        index--;
    }
    octal_str[index] = 'o';
    octal_str[index - 1] = '0';

    return octal_str;
}

int potencia(int base, int expoente) {
    int resultado = 1;
    for (int i = 0; i < expoente; i++) {
        resultado *= base;
    }
    return resultado;
}

unsigned int hex_to_decimal(char* hex_str) {
    // Alocando memória para armazenar o número decimal
    unsigned int decimal_int; // 10 bits + caractere nulo
    int hex_int = 0;
    int index = 7;

    // Convertendo decimal para octal
    while (hex_str[index] != 'x' && index >= 0) {
        if(hex_str[index] - '0' > 9){
            hex_int = hex_str[index] - 55;
        } else {
            hex_int = hex_str[index] - '0';
        }
        decimal_int += potencia(16, 7 - hex_int);
        index--;
    }

    return decimal_int;
}

char* swap_endianness(char* binary_str) {
    // Inicializando a nova string binária
    char swapped_binary[33]; // 32 bits + caractere nulo
    swapped_binary[32] = '\0';

    // Trocando endianness
    for (int i = 0; i < 4; i++) {
        strncpy(swapped_binary + i * 8, binary_str + (3 - i) * 8, 8);
    }

    return swapped_binary;
}

int invert_bin(char* binary_str){
    // Invertendo a string passada como parametro
    for(int i = 2; i<=35; i++){
        if (binary_str[i] == '0'){
            binary_str[i] = '1';
        } else {
            binary_str[i] = '0';
        }
    }

    return 0;
}

unsigned int binary_to_decimal(char* binary_str) {
    // Convertendo string binária para decimal
    unsigned int decimal_num = 0;
    for (int i = 0; i < 32; i++) {
        decimal_num = (decimal_num << 1) + (binary_str[i] - '0');
    }

    return decimal_num;
}

int main() {
    unsigned int decimal_num = 12345;
    printf("Decimal: %u\n", decimal_num);

    // Convertendo para binário
    char* binary_num = decimal_to_binary(decimal_num);
    printf("Binário: %s\n", binary_num);

    // Convertendo para hexadecimal
    char* hexadecimal_num = decimal_to_hexadecimal(decimal_num);
    printf("Hexadecimal: %s\n", hexadecimal_num);

    // Convertendo para octal
    char* octal_num = decimal_to_octal(decimal_num);
    printf("Octal: %s\n", octal_num);

    // Trocando endianness
    char* swapped_binary = swap_endianness(binary_num);
    printf("Endianness trocada: %s\n", swapped_binary);

    // Convertendo binário com endianness trocada para decimal
    unsigned int decimal_num_swapped = binary_to_decimal(swapped_binary);
    printf("Decimal (com endianness trocada): %u\n", decimal_num_swapped);

    return 0;
}
