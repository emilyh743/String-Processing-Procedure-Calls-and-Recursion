#include<stdio.h>
#include<string.h>
#define TRUE 1

char input1[22];     // To read in a string of up to 20 hexits plus newline and null
char input2[22];     // To read in a string of up to 20 hexits plus newline and null

int h_to_i(char* str);
int NchooseK(int n, int k);

int main() {

  int n, k, result;
  int value, i, strlen;

                    // Do the following inside a loop
  while (TRUE) {
    fgets(input1, 22, stdin);
    n = h_to_i(input1);

    if (n == 0) {
    break;
    }
    fgets(input2, 22, stdin);
    k = h_to_i(input2);
    
   
    result = NchooseK(n, k);
    printf("%d\n", result);
  }
}

int h_to_i(char* str) {
 int value;
   int len = strlen(str) - 1;

 for (int i = 0; i < len; i++) {
    if (str[i] >= '0' && str[i] <= '9')
      value = (value * 16) + (str[i] - '0');
    if (str[i] >= 'a' && str[i] <= 'f')
      value = (value * 16) + (str[i] - 'a') + 10;
 }
return value; 
}

int NchooseK(int n, int k) {
  if (k == 0) {  // NchooseK(n, 0) = 1;
          return 1;
        } else
        if (k == n) {  //NchooseK(n, n) = 1
          return 1;
        } else {                  //NchooseK(n, k) = NchooseK(n-1, k-1) + NchooseK(n-1, k)
          return NchooseK(n-1, k-1) + NchooseK(n-1, k);
        } 
}
