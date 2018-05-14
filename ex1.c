#include<stdio.h>
#include<string.h>
#define TRUE 1

char input[22];     // To read in a string of up to 20 digits plus newline and null

int h_to_i(char* str);

int main() {

  int value;
  int i;
  int strlen;
                    // Do the following inside a loop
  while (TRUE) { //to move through index
    fgets(input, 22, stdin);
    value = h_to_i(input);

    if (value == 0)  //to terminate program if input is '0'. *had if(input==0)
        break;
  printf("%d\n", value);
}
}

int h_to_i(char* str) {
   int value=0;
   int len = strlen(str) - 1;

 for (int i = 0; i < len; i++) {
    if (str[i] >= '0' && str[i] <= '9')
      value = (value * 16) + (str[i] - '0');
    if (str[i] >= 'a' && str[i] <= 'f')
      value = (value * 16) + (str[i] - 'a') + 10;
 }
  return value; //jr $ra in ASSEMBLY
}
