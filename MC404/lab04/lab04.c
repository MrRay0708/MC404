#define STDIN_FD  0
#define STDOUT_FD 1

int read(int __fd, const void *__buf, int __n){
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall write code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)  // Output list
    : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
  __asm__ __volatile__(
    "mv a0, %0           # file descriptor\n"
    "mv a1, %1           # buffer \n"
    "mv a2, %2           # size \n"
    "li a7, 64           # syscall write (64) \n"
    "ecall"
    :   // Output list
    :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
}

int potencia(int base, int expoente) {
    int resultado = 1;
    for (int i = 0; i < expoente; i++) {
        resultado *= base;
    }
    return resultado;
}

int decimal_to_base(unsigned int decimal_num, int base, int tamanho, char* string){
    // Inicializando a string binária
    char* alfabeto;

    switch (base)
    {
    case 2:
      alfabeto = "01";
      break;
    case 8:
      alfabeto = "01234567";
      break;
    case 16:
      alfabeto = "0123456789ABCDEF";
      break;
    }
    string[tamanho - 1] = '\n';
    string[tamanho - 2] = '\0';
    int index = tamanho - 3;

    // Convertendo decimal para base
    unsigned int temp = decimal_num;
    while (decimal_num > 0 && index >= 0) {
        int resto = decimal_num % base;
        string[index] = alfabeto[resto];
        decimal_num = decimal_num / base;
        index--;
    }
    decimal_num = temp;

    switch (tamanho)
    {
    case 36:
        string[index] = 'b';
        break;
    case 12:
        string[index] = 'x';
        break;
    case 15:
        string[index] = 'o';
        break;
    }
    string[index - 1] = '0';

    return 0;
}

int hex_to_bin(char* hex_str, char* bin_str) {
  // Inicializando variáveis
  int index = 2;
  // Convertendo hexadecimal para binário
  while (hex_str[index] != '\0') {
    switch (hex_str[index]){
    case '0':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case '1':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case '2':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case '3':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case '4':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case '5':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case '6':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case '7':
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case '8':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case '9':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case 'A':
    case 'a':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case 'B':
    case 'b':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case 'C':
    case 'c':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case 'D':
    case 'd':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    case 'E':
    case 'e':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '0';
      index++;
      break;
    case 'F':
    case 'f':
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      bin_str[index] = '1';
      index++;
      break;
    }
    bin_str[1] = 'b';
    bin_str[0] = '0';
  }
  if (index == 7){
    return 1;
  }
  return 0;
}

int binary_to_decimal(char* binary_str) {
    // Convertendo string binária para decimal
    int tam=2;
    while(binary_str[tam] != '\0'){
      tam++;
    }
    tam--; //6
    
    int decimal_num = 0;
    int index = 2;
    while(binary_str[index] != '\0') {
        decimal_num += (decimal_num * potencia(2, tam - index)) * (binary_str[index] - '0');
        index++;
    }

    return decimal_num;
}

int invert_bin(char* binary_str){
    // Invertendo a string passada como parametro
    int i = 2;

    while(binary_str[i] != '\0'){
      if (binary_str[i] == '0'){
        binary_str[i] = '1';
      } 
      else if (binary_str[i] == '1'){
        binary_str[i] = '0';
      }
      i++;
    }
    
    return 0;
}

int int_to_str(unsigned int numero, char* decimal_str){
  int index = 0;
  while (numero > 0){
    decimal_str[0] = (numero % 10) + '0';
    for (int x = index; x > 0; x--) {
      decimal_str[x] = decimal_str[x-1];
    }
    numero = numero / 10;
    index++;
  }
  decimal_str[index] = '\0';
  decimal_str[index + 1] = '\n';
  for (int y = 0; y <= index; y++) {
    decimal_str[y] = decimal_str[y + 1];
  }
  return 1;
}

unsigned int str_to_int(char* decimal_str, int parametro){
  // Converte o número de string para int
  int tam=0;
  while(decimal_str[tam] != '\0'){
    tam++;
  }
  tam -= 1 - parametro;

  unsigned int resultado = 0;
  int index = 0 + parametro;
  while (decimal_str[index] != '\0'){
    resultado += (decimal_str[index] - '0') * potencia(10, tam - index);
    index++;
  }
  if (parametro == 1){
    resultado = resultado /10;
  }
  return resultado;
}

int swap_endianness(char* binary_str, char* swapped_binary) {
    // Trocando endianness
    int tam = 0;
    while(binary_str[tam] != '\0') {
      tam += 1;
    }
    tam -= 2;
    int n_buffer = tam % 4;

    char copia[((tam / 4) + 1)*4];
    int i;
    for (i = 0; i < n_buffer; i++){
      copia[i] = '0';
    }
    for (int j = 0; j < tam; i++){
      copia[i] = binary_str[j];
      j++;
    }
    
    for (int index = 0; index < (tam / 4) + 1; index++) {
        swapped_binary[(index*4) + 2] = copia[(3 - index)*4 - 4];
        swapped_binary[(index*4) + 3] = copia[(3 - index)*4 - 3];
        swapped_binary[(index*4) + 4] = copia[(3 - index)*4 - 2];
        swapped_binary[(index*4) + 5] = copia[(3 - index)*4 - 1];
    }

    return 0;
}

void exit(int code){
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}

int main(){
  char str[20];
  /* Read up to 20 bytes from the standard input into the str buffer */
  int n = read(STDIN_FD, str, 20);

  /*Criando uma cópia do input para manipulação*/
  char copia[20];
  int index = 0;
  while(str[index] != '\n'){
    copia[index] = str[index];
    index++;
  }
  /// Até aqui ta tudo bem!!!!!!!!!!!

  if (copia[0] == '0'){ // Entrada hexadecimal
    // Decimal em char
    char decimal_char[36];

    // Inicializando variáveis
    unsigned int decimal;
    char bin_str[36];
    char swapped_str[36];
    char hexa_str[12];
    char octal_str[15];

    // Hexadecimal para binário
    int neg = hex_to_bin (&copia[1], bin_str);
    
    if (bin_str[2] == 1 && neg == 1){ // Entrada hexadecimal negativa
      // Invertendo binário
      invert_bin(bin_str);

      decimal = binary_to_decimal(bin_str);
    }
    else{ // Entrada hexadecimal positiva
      decimal = binary_to_decimal(bin_str);
    }
    // Decimal para binário
    decimal_to_base(decimal, 2, 36, bin_str);
    // Decimal para binario trocado
    swap_endianness(bin_str, swapped_str);
    unsigned int decimal_invertido = binary_to_decimal(swapped_str);
    decimal_to_base(decimal_invertido, 2, 36, swapped_str);
    // Decimal para hexa
    decimal_to_base(decimal, 16, 12, hexa_str);
    // Decimal para octal
    decimal_to_base(decimal, 8, 15, octal_str);
    // Decimal em String
    int_to_str(decimal, decimal_char);
    // Print
    write(STDOUT_FD, bin_str, 36); // binario
    write(STDOUT_FD, decimal_char, 36); // decimal
    write(STDOUT_FD, swapped_str, 36); // binario invertido convertido para decimal
    write(STDOUT_FD, str, n); // hexadecimal
    write(STDOUT_FD, octal_str, 15); // octal
  } 
  else { // Entrada decimal
    if (copia[0] == '-'){ // Entrada decimal negativa
      unsigned int decimal = str_to_int (&copia[0], 1);
      // Inicializando variáveis
      char bin_str[36];
      char swapped_str[36];
      char hexa_str[12];
      char octal_str[15];
      // Decimal para binário 
      decimal_to_base(decimal, 2, 36, bin_str);
      // Invertendo binário
      invert_bin(bin_str); 
      decimal_to_base(decimal, 2, 36, bin_str);
      // Decimal para binario trocado 
      swap_endianness(bin_str, swapped_str);
      write(STDOUT_FD, swapped_str, 36);
      unsigned int decimal_invertido = binary_to_decimal(swapped_str);
      decimal_to_base(decimal_invertido, 2, 36, swapped_str);
      // Decimal para hexa
      decimal_to_base(decimal, 16, 12, hexa_str);
      // Decimal para octal
      decimal_to_base(decimal, 8, 15, octal_str);
      // Print
      write(STDOUT_FD, bin_str, 36); // binario
      write(STDOUT_FD, str, n); // decimal
      write(STDOUT_FD, swapped_str, 36); // binario invertido convertido para decimal
      write(STDOUT_FD, hexa_str, 12); // hexadecimal
      write(STDOUT_FD, octal_str, 15); // octal
    } 
    else { // Entrada decimal positiva
      unsigned int decimal = str_to_int (&copia[0], 0);

      // Inicializando variáveis
      char bin_str[36];
      char swapped_str[36];
      char hexa_str[12];
      char octal_str[15];
      // Decimal para binário
      decimal_to_base(decimal, 2, 36, bin_str);
      // Decimal para binario trocado
      swap_endianness(bin_str, swapped_str);
      unsigned int decimal_invertido = binary_to_decimal(swapped_str);
      decimal_to_base(decimal_invertido, 2, 36, swapped_str);
      // Decimal para hexa
      decimal_to_base(decimal, 16, 12, hexa_str);
      // Decimal para octal
      decimal_to_base(decimal, 8, 15, octal_str);
      // Print
      write(STDOUT_FD, bin_str, 36); // binario
      write(STDOUT_FD, str, n); // decimal
      write(STDOUT_FD, swapped_str, 36); // binario invertido convertido para decimal 
      write(STDOUT_FD, hexa_str, 12); // hexadecimal
      write(STDOUT_FD, octal_str, 15); // octal
    }
  }
  return 0;
}

void _start(){
  int ret_code = main();
  exit(ret_code);
}
