# Starter file for ex1.asm

.data 0x0
input1: .space 22
input2: .space 22
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
	
    	# fgets(input1, 22, stdin);
    	ori $v0, $0, 8
	ori $a1, $0, 22
	la $a0, input1
	syscall
   	# n = h_to_i(input1);
   	la $t2, input1  #address of 1st byte
	jal h_to_i
	add $t1, $v0, $0
   	# if (n == 0)
    	#    break;
    	beq $0, $t1, end
    	# fgets(input2, 22, stdin);
    	ori $v0, $0, 8
    	ori $a1, $0, 22
	la $a0, input2
	syscall
	# k = h_to_i(input2);
    	la $t2 input2
    	jal h_to_i
    	add $t4, $v0, $0
    	
    	# result = NchooseK(n, k);
    	add $a0, $t1, $0  # move n to a0
    	add $a1, $t4, $0  # move k to a1
	jal NchooseK
    	add $t5, $v0, $0   #
    	
  	# printf("%d\n", result);
  	ori $v0, $0, 1
	or $a0, $t5, $0
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
	
NchooseK:
	beq $a1, $0, return1
	beq $a0, $a1, return1
	add $t0, $a0, $0  # initializer, i = n
	add $t4, $a1, $0  # j = k
	sub $t1, $a0, $a1 # n-k
	addi $t1, $t1, 1 # n-k+1
	addi $t2, $0, 1 # set numerator to 1
	addi $t3, $0, 1	# set denominator to 1
	# $t2 = numerator    $t3 = denominator

	loop1:
	blt $t0, $t1, end_loop1
	mult $t2, $t0  # numerator *= i;
	mflo $t2
	addi $t0, $t0, -1
	j loop1
	end_loop1:
	
	loop2:
	ble $t4, 1, end_loop2
	mult $t3, $t4
	mflo $t3
	addi $t4, $t4, -1 # dec by 1
	j loop2
	end_loop2:
	
	return:
	div $t2, $t3 # numerator/denominator
	mflo $v0
	jr $ra
	
	return1:
	addi $v0, $0, 1
	jr $ra
	
