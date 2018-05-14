# Starter file for ex1.asm

.data 0x0
input: .space 22
newline: .asciiz "\n"
        
.text 0x3000

# Starter file for ex1.asm

main:
	#----------------------------------------------------------------#
	# Write code here to do exactly what main does in the C program.
	#
	# Please follow these guidelines:
	#
	#	Use syscall 8 to do the job of fgets()
	#	Then call h_to_i to perform conversion from string to integer
	#	Then use syscall 1 to print the integer result
	#----------------------------------------------------------------#
	
    	# fgets(input, 22, stdin);
    	ori $v0, $0, 8
	ori $a1, $0, 22
	la $a0, input
	syscall
   	# value = h_to_i(input);
   	la $t2, input  #address of 1st byte
	jal h_to_i
	add $t1, $v0, $0
	
   	# if (value == 0)
    	#    break;
    	beq $0, $v0,  end
  	# printf("%d\n", value);
  	ori $v0, $0, 1
	or $a0, $t1, $0
	syscall
	#print newline
	ori $v0, $0, 4 # prints newline
	la $a0, newline
	syscall
	j main
end: 
	ori   $v0, $0, 10     # system call 10 for exit
	syscall               # we are out of here.



h_to_i:
	#----------------------------------------------------------------#
	# $a0 has address of the string to be parsed.
	#
	# Write code here to implement the function you wrote in C.
	# Since this is a leaf procedure, you may be able to get away
	# without using the stack at all.
	#
	# $v0 should have the integer result to be returned to main.
	#----------------------------------------------------------------#
	
	# int value;
   	# int len = strlen(str) - 1;
	ori $v0, $0, 0  #init. to 0
	loop:
	lb $a1, ($t2)   # would print ascii val of 1st byte
   	#   if (str[i] >= '0' && str[i] <= '9')
   	addi $a1, $a1, -48   # $a1 - 48
   	sgt $a2, $a1, 9  # $a2 = 1 if > 9, 0 if <= 9
   	beq $a2, 1, letter
        
        #   value = (value * 16) + (str[i] - '0');
        li $t4, 16
        mult $v0, $t4
        mflo $v0
        add $v0, $v0, $a1
        
        addi $t2, $t2, 1	# next byte
        lb $a1, ($t2)
        beq $a1, 10, quit
	j loop
	
	letter:
	li $t4, 16
        mult $v0, $t4
        mflo $v0
        add $v0, $v0, $a1
        addi $v0, $v0, -39
        
        addi $t2, $t2, 1	# next byte
        lb $a1, ($t2)
        beq $a1, 10, quit
	j loop
	
	quit:
	jr $ra