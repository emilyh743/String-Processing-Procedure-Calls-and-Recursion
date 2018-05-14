# String-Processing-Procedure-Calls-and-Recursion

ex1.c

Program with function h_to_i that converts a string of ASCII hexits (hexadecimal digits) into a 32-bit integer. The function will receive as an argument the starting address of the string (excluding the customary "0x") and must return a 32-bit integer containing the integer value of the string. Assume that the string is an ASCIIZ string, i.e., ends with the null character (ASCII code 0). Don't need to check for errors in the string, i.e., you may assume the string contains only characters '0' through '9' and 'a' though 'f' (i.e., their corresponding ASCII codes), and will not represent a negative number or a non-decimal value or too large a number. You can further assume only lowercase letters will be present. For example, h_to_i called with the argument "dada" will return the integer 56026.

ex1.asm

MIPS equivalent of ex1.c.

ex2.c

Program with a non-recursive (i.e., simple iterative) implementation of a function NchooseK() that computes NchooseK of two input numbers n and k (i.e., the value of the binomial coefficient nCk). This function takes in two integers, each on a separate line, and will return an integer result. Assume that the function will be called only with an argument small enough so that the result does not overflow, i.e., fits within 32 bits.

ex2.asm

MIPS equivalent of ex2.c.

ex3.c

Program with a recursive implementation of NchooseK().

This function takes in two integers and will return an integer result. All other assumptions Exercise 2 still hold.

ex3.asm

MIPS equivalent of ex3.c.
