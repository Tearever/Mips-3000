############################################################################
# Program 2 ################################################################
# Name : Trevor Wright #####################################################
# ID : 560 #################################################################

.data

STR_QUESTION_ONE: .asciiz "Enter the origin of your number sequence (1-5): "
STR_QUESTION_TWO: .asciiz "Enter your multiple factor (2-7): "
STR_QUESTION_THREE: .asciiz "Enter the total number of the numbers (3-30): "
STR_SUM_TOTAL: .asciiz "Check-sum: "
NEW_LINE: .asciiz "\n"
SPACE:	.asciiz ". "

.text

.globl main

main:

	# set the parameters #########################
	li	$t6, 0

loop_01:

	# output text to screen #######################
	li	$v0, 4
	la	$a0, STR_QUESTION_ONE
	syscall

	# input from user ##############################
	li	$v0, 5
	syscall
	
	# Check if valid input #######################
	li	$a0, 1
	bge	$v0, $a0, greater_than_one

	# repeat loop ################################
	j	loop_01

greater_than_one:
	
	# Check if valid input #######################
	li	$a0, 5
	ble	$v0, $a0, less_than_five

	# repeat loop ################################
	j	loop_01

less_than_five:

	# Passed Validity check Q1 ###################
	move $t0, $v0

	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	end_loop_01	


end_loop_01:

loop_02:

	# output text to screen #######################
	li	$v0, 4
	la	$a0, STR_QUESTION_TWO
	syscall

	# input from user ##############################
	li	$v0, 5
	syscall
	
	# Check if valid input #######################
	li	$a0, 2
	bge	$v0, $a0, greater_than_two

	# repeat loop ################################
	j	loop_02

greater_than_two:
	
	# Check if valid input #######################
	li	$a0, 7
	ble	$v0, $a0, less_than_seven

	# repeat loop ################################
	j	loop_02

less_than_seven:

	# Passed Validity check Q2 ###################
	move $t1, $v0

	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	end_loop_02	


end_loop_02:

loop_03:

	# output text to screen #######################
	li	$v0, 4
	la	$a0, STR_QUESTION_THREE
	syscall

	# input from user ##############################
	li	$v0, 5
	syscall
	
	# Check if valid input #######################
	li	$a0, 3
	bge	$v0, $a0, greater_than_three

	# repeat loop ################################
	j	loop_03

greater_than_three:
	
	# Check if valid input #######################
	li	$a0, 30
	ble	$v0, $a0, less_than_thirty

	# repeat loop ################################
	j	loop_03

less_than_thirty:

	# Passed Validity check Q3 ###################
	move $t2, $v0

	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	end_loop_03	


end_loop_03:

loop_04:

	# print the number ###########################
	li	$v0, 1
	move	$a0, $t0
	syscall
	
	# Format after number ########################
	li	$v0, 4
	la	$a0, SPACE
	syscall
	
	# Add to total sum ###########################
	add	$t6, $t6, $t0 

	# decrease loop counter ######################
	li	$a1, 1
	sub	$t2, $t2, $a1	

	# Increase Number ############################
	add	$t0, $t0, $t1
	
	# repeat enough? #############################
	bne	$a1, $t2, loop_04
	j	end_of_loop_04

end_of_loop_04:

	# Output last Number #########################
	li	$v0, 1
	move	$a0, $t0
	syscall
	
	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# Add to total sum ###########################
	add	$t6, $t6, $t0

	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# output text to screen ######################
	li	$v0, 4
	la	$a0, STR_SUM_TOTAL
	syscall

	# Output Total Sum ###########################
	li	$v0, 1
	move	$a0, $t6
	syscall

	# New Line ###################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall



	# stop this program ##########################
	jr	$31



# ENE OF LINES ######################################