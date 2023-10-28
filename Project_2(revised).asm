#############################################################################
# Project 2 #################################################################
# Name : Trevor Wright ######################################################
# ID : 560 ##################################################################

.data

message_1: .asciiz "Enter the principal: "
message_2: .asciiz "Enter the interest rate (0.0 < interest < 1.0, 0.01 for 1%): "
message_3: .asciiz "Enter the target balance: "
message_4: .asciiz "Enter the number of the last years you would like to see the balance (-1: all): "
message_5: .asciiz "the balance at the end of a year"
message_6: .asciiz "year "
message_7: .asciiz ": "
message_8: .asciiz "it takes "
message_9: .asciiz " years."


error_message: .asciiz "Invalid input"

UPPER_BOUND: .float 0.99
LOWER_BOUND: .float 0.01

NEW_LINE: .asciiz "\n"

.text
.globl main

###################################################################################
main:
# create stack frame
	subu		$sp, $sp, 32

# save return address
	sw		$ra, ($sp)

# set the parameters
	li		$t2, 0			# year counter

# principal_loop

	# Output message_1
	li		$v0, 4
	la		$a0, message_1
	syscall

	# Input from user
	li		$v0, 6
	syscall

	mov.s	$f1, $f0

interest_loop:

	# Output message_2
	li		$v0, 4
	la		$a0, message_2
	syscall

	# Input from user
	li		$v0, 6
	syscall

	# Check if valid input
	l.s		$f12, UPPER_BOUND
	c.le.s		$f0, $f12
	bc1t		upper_Valid
	bc1f		error

error:

	# Output error_message
	li		$v0, 4
	la		$a0, error_message
	syscall

	# Output NEW_LINE
	li		$v0, 4
	la		$a0, NEW_LINE
	syscall

	j		interest_loop


upper_Valid:

	l.s		$f12, LOWER_BOUND
	c.le.s		$f12, $f0
	bc1t		lower_Valid
	bc1f		error

lower_Valid:

	mov.s	$f2, $f0

# target_balance_loop

	# Output message_3
	li		$v0, 4
	la		$a0, message_3
	syscall

	# Input from user
	li		$v0, 6
	syscall

	mov.s		$f3, $f0

# display_last_years

	# Output message_4
	li		$v0, 4
	la		$a0, message_4
	syscall

	# Input from user
	li		$v0, 5
	syscall

	move		$t4, $v0

	# Output message_5
	li		$v0, 4
	la		$a0, message_5
	syscall

	# Output NEW_LINE
	li		$v0, 4
	la		$a0, NEW_LINE
	syscall	

# Recursive statement	
	jal		compound_interest_calculator

# Output message_8
	li		$v0, 4
	la		$a0, message_8
	syscall

	# Output month number
	li		$v0, 1
	move		$a0, $t3
	syscall

	# Output message_9
	li		$v0, 4
	la		$a0, message_9
	syscall

# restore return address
	lw		$ra, ($sp)

# remove stack frame
	subu		$sp, $sp, -32

# end of program
	jr	$31
###################################################################################

compound_interest_calculator:

# create stack frame
	subu		$sp, $sp, 32

# save return address
	sw		$ra, ($sp)

# save important variables
	swc1		$f1, 4($sp)
	sw		$t2, 8($sp)	

# Update principal 
	mul.s		$f9, $f1, $f2
	add.s		$f1, $f1, $f9

# Update month number
	add		$t2, $t2, 1

# last month
	move		$t3, $t2

# Terminating Condition
	c.lt.s		$f1, $f3			# ($f1 < $f3)
	bc1f		stop_Recursion

# Recursive statement	
	jal		compound_interest_calculator

stop_Recursion:

	beq		$t4, -1, output_to_screen
	blt		$t4, 1, skip_output		# ($t4 < 1)


output_to_screen:
	# Output message_6
	li		$v0, 4
	la		$a0, message_6
	syscall

	# Output month number
	li		$v0, 1
	move		$a0, $t2
	syscall

	# Output message_7
	li		$v0, 4
	la		$a0, message_7
	syscall

	# Output principal
	li		$v0, 2
	mov.s		$f12, $f1
	syscall

	# Output NEW_LINE
	li		$v0, 4
	la		$a0, NEW_LINE
	syscall	

	bne 		$t4, -1, decrament_display_years
	j 		skip_output
	
	decrament_display_years:
	sub		$t4, $t4, 1

skip_output:

# restore important variables
	lw		$t2, 8($sp)	
	lwc1		$f1, 4($sp)

# restore return address
	lw		$ra, ($sp)

# remove stack frame
	subu		$sp, $sp, -32

jr	$ra
###################################################################################
