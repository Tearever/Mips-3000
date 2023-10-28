############################################################################
# Program 3 ################################################################
# Name : Trevor Wright #####################################################
# ID : 560 #################################################################

.data 

message1: .asciiz "Enter the principal in $ ( 100.00 - 1,000,000.00): "
message2: .asciiz "Enter the annual interest rate (0.005 - 0.399): "
message3: .asciiz "Enter the monthly payment amount in $ (1.00 - 2,000,000.00): "

NEW_LINE: .asciiz "\n"

ERROR_message1: .asciiz "You made an invalid input for your principal. Enter a valid input for the principal."
ERROR_message2: .asciiz "You made an invalid input for your annual interest rate. Enter a valid input for the annual interest rate."
ERROR_message3: .asciiz "You made an invalid input for your monthly payment amount. Enter a valid input for the monthly payment amount."

payment_plan_object_1: .asciiz "month "
payment_plan_object_2: .asciiz ": current principal = "

end_message1: .asciiz "It will take "
end_message2: .asciiz " months to complete the loan."

yearly_interest:	.float 0.08219

	.text
	.globl main

main:

	# set the parameters ###############################################
	li	$t1, 1
	li	$t2, 1					# loop counter

loop_01:	
	# Output message1 ##################################################
	li	$v0, 4
	la	$a0, message1
	syscall

	# Input from user ##################################################
	li	$v0, 6
	syscall

	# Check If Valid Input #############################################
	li.s	$f1, 1000000.00
	c.le.s	$f0, $f1
	bc1t less_than_million
	bc1f error_message1

less_than_million:

	# Check If Valid Input #############################################
	li.s	$f1, 100.00
	c.le.s	$f1, $f0
	bc1t	end_of_loop_01
	bc1f	error_message1

error_message1:

	# Output ERROR_message1 #############################################
	li	$v0, 4
	la	$a0, ERROR_message1
	syscall

	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	loop_01


end_of_loop_01:

	# Move user's input to another register ##############################
	mov.s	$f6, $f0

loop_02:	
	# Output message2 ##################################################
	li	$v0, 4
	la	$a0, message2
	syscall

	# Input from user ##################################################
	li	$v0, 6
	syscall

	# Check If Valid Input #############################################
	li.s	$f1, 0.3999
	c.le.s	$f0, $f1
	bc1t less_than_0.3999
	bc1f error_message2

less_than_0.3999:

	# Check If Valid Input #############################################
	li.s	$f1, 0.005
	c.le.s	$f1, $f0
	bc1t	end_of_loop_02
	bc1f	error_message2

error_message2:

	# Output ERROR_message2 #############################################
	li	$v0, 4
	la	$a0, ERROR_message2
	syscall

	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	loop_02


end_of_loop_02:

	# Move user's input to another register ##############################
	mov.s	$f7, $f0

loop_03:	
	# Output message3 ##################################################
	li	$v0, 4
	la	$a0, message3
	syscall

	# Input from user ##################################################
	li	$v0, 6
	syscall

	# Check If Valid Input #############################################
	li.s	$f1, 2000000.00
	c.le.s	$f0, $f1
	bc1t less_than_two_million
	bc1f error_message3

less_than_two_million:

	# Check If Valid Input #############################################
	li.s	$f1, 1.00
	c.le.s	$f1, $f0
	bc1t	end_of_loop_03
	bc1f	error_message3

error_message3:

	# Output ERROR_message3 #############################################
	li	$v0, 4
	la	$a0, ERROR_message3
	syscall

	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall
	j	loop_03


end_of_loop_03:

	# Move user's input to another register ##############################
	mov.s	$f8, $f0

calculate_Payment_Info:

	# Test if first entry ################################################
	beq	$t2, $t1 first_entry
	j	other_entries

first_entry:
	# Output payment_plan_object_1 #######################################
	li	$v0, 4
	la	$a0, payment_plan_object_1
	syscall

	# Output month number ################################################
	li	$v0, 1
	move	$a0, $t2
	syscall

	# Output payment_plan_object_2 #######################################
	li	$v0, 4
	la	$a0, payment_plan_object_2
	syscall

	# Output float number ################################################
	li	$v0, 2
	mov.s	$f12, $f6
	syscall

	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

other_entries:
	# Calculate monthly interest #########################################
	mul.s	$f3, $f6, $f7
	l.s	$f12, yearly_interest
	mul.s	$f3, $f3, $f12

	# Amount for payment to the principal ################################
	sub.s	$f4, $f8, $f3

	# Update remaining principal #########################################
	sub.s	$f6, $f6, $f4

	# Check if remaining principal is less than threshold (0.01) #########
	li.s	$f1, 0.01
	c.lt.s	$f6, $f1
	bc1f	continue_loop

	# Exit the loop if remaining principal is less than 0.01
	j end_of_calculations

continue_loop:

	# Increase the loop counter ##########################################
	add	$t2, $t2, $t1				# $t2 = $t2 + $t1

	# Output payment_plan_object_1 #######################################
	li	$v0, 4
	la	$a0, payment_plan_object_1
	syscall

	# Output month number ################################################
	li	$v0, 1
	move	$a0, $t2
	syscall

	# Output payment_plan_object_2 #######################################
	li	$v0, 4
	la	$a0, payment_plan_object_2
	syscall

	# Output float number ################################################
	li	$v0, 2
	mov.s	$f12, $f6
	syscall

	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# Did I repeat enough ################################################
	li.s	$f1, 0.01
	c.le.s	$f1, $f6
	bc1t	other_entries
	bc1f	end_of_calculations

end_of_calculations:
	# Output NEW_LINE ####################################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall	

	# Output end_message1 #################################################
	li	$v0, 4
	la	$a0, end_message1
	syscall

	# Output month number ################################################
	li	$v0, 1
	move	$a0, $t2
	syscall

	# Output end_message2 #################################################
	li	$v0, 4
	la	$a0, end_message2
	syscall

# Stop Program ###############################################################
j 	$31

###############################################################################
