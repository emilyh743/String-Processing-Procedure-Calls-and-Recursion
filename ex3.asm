# Starter file for ex1.asm

.data 0x0
input1: .space 22
input2: .space 22
newline: .asciiz "\n"
        
.text 0x3000
.globl main

main:
        ori     $sp, $0, 0x3000     # Initialize stack pointer to the top word below .text
                                    # The first value on stack will actually go at 0x2ffc
                                    #   because $sp is decremented first.
        addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame

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
   	#la $v0, input1
	jal h_to_i
	add $t1, $v0, $0   # for checking if $v0 is equal to 0
   	# if (n == 0)
    	#    break;
    	beq $0, $t1, end
    	add $s0, $v0, $0
    	# fgets(input2, 22, stdin);
    	ori $v0, $0, 8
    	ori $a1, $0, 22
	la $a0, input2
	syscall
	# k = h_to_i(input2);
    	jal h_to_i
    	
    	# result = NchooseK(n, k);
    	add $a1, $v0, $0  # move n to a1
    	add $a0, $s0, $0  # move $s0 to $a0
	jal NchooseK
    	add $a0, $v0, $0
    	
  	# printf("%d\n", result);
  	ori $v0, $0, 1
	
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
	add $t2, $a0, $0
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
	addi    $sp, $sp, -8        # Make room on stack for saving $ra and $fp
	sw      $ra, 4($sp)         # Save $ra
	sw      $fp, 0($sp)         # Save $fp

	addi    $fp, $sp, 4         # Set $fp to the start of proc1's stack frame

                                    # From now on:
                                    #     0($fp) --> $ra's saved value
                                    #    -4($fp) --> caller's $fp's saved value
                    

    # =============================================================
    # Save any $sx registers that proc1 will modify
                                # Save any of the $sx registers that proc1 modifies
	addi    $sp, $sp, -12       # e.g., $s0, $s1, $s2, $s3
	sw      $s0, 8($sp)         # Save $s0
	sw	$s1, 4($sp)
	sw	$s2, 0($sp)
                                # From now on:
                                #    -8($fp) --> $s0's saved value
    # =============================================================

	
	# base case
	 addi $v0, $0, 1
	add $s0, $0, $a0    #HERE *********
	add $s1, $0, $a1
	
	beq $s1, $0, endofNCK	# k == 0? then return 1
	beq $s0, $s1, endofNCK	# n == k? then return 1
	addi $a0, $a0, -1	# $a0-1
	addi $a1, $a1, -1	# $a1-1
	jal NchooseK
	add $s2, $v0, $0	#so 2nd jal won't destroy
	#call NchooseK(n-1, k)
	addi $a0, $s0, -1
	addi $a1, $s1, 0
	jal NchooseK
	add $v0, $v0, $s2	# NchooseK(n-1,k-1) + NchooseK(n-1,k)
	
	

	
endofNCK:

	lw $s0, -8($fp)         # Restore $s0
	lw $s1, -12($fp)         # Restore $s1
	lw $s2, -16($fp)		# Restore $s2
	
	addi    $sp, $fp, 4     # Restore $sp
        lw      $ra, 0($fp)     # Restore $ra
        lw      $fp, -4($fp)    # Restore $fp
        jr      $ra             # Return from procedure

    # =============================================================

	
