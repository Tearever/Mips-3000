############################################################################
# Program 1 ################################################################
# Name : Trevor Wright #####################################################
# ID : 560 #################################################################

.data

STR_MESSAGE: .asciiz "Enter your current driving speed in MPH (1 to 200): "
STR_MESSAGE2: .asciiz "Enter the absolute speed limit specified for the road you are currently running on (15 - 70): "

NEW_LINE:  .asciiz "\n"

ERROR_CDS: .asciiz "You made an invalid input for your current driving speed. Enter a valid input for your current driving speed."
ERROR_ASL: .asciiz "You made an invalid input for the absolute speed limit. Enter a valid input for the speed limit."

TIER_ZERO_EXCEED_SPEED: .asciiz "You are a safe driver!"
TIER_ONE_EXCEED_SPEED: .asciiz "$120 fine"
TIER_TWO_EXCEED_SPEED: .asciiz "$140 fine"
TIER_THREE_EXCEED_SPEED: .asciiz "Class B misdemeanor and carries up to six months in jail and a maximum $1,500 in fines."
TIER_FOUR_EXCEED_SPEED: .asciiz "Clas A misdemeanor and carries up to one year in jail and a maximum $2,500 in fines."

.text
.globl main

main:

# set the parameters #########################################
	
loop_01:

	# output text to screen #######################
	li	$v0, 4
	la	$a0, STR_MESSAGE
	syscall

	# input from user ##############################
	li	$v0, 5
	syscall

	# check if valid input #########################
	li	$a0, 0
	li	$a1, 201
	bgt	$v0, $a0, greater_than_0
	j	error_loop_01

error_loop_01:

	li	$v0, 4
	la	$a0, ERROR_CDS
	syscall

	# new line ####################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# repeat loop ##################################
	j	loop_01

greater_than_0:

	blt	$v0, $a1, end_loop_01

	# repeat loop ##################################
	j	error_loop_01

end_loop_01:

	# Moving integer into other register #########
	move $s0, $v0

loop_02:

	# output text to screen #######################
	li	$v0, 4
	la	$a0, STR_MESSAGE2
	syscall

	# input from user ##############################
	li	$v0, 5
	syscall

	# check if valid input #########################
	li	$a0, 14
	li	$a1, 71
	bgt	$v0, $a0, greater_than_14
	j	error_loop_02

error_loop_02:

	li	$v0, 4
	la	$a0, ERROR_ASL
	syscall

	# new line ####################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# repeat loop ##################################
	j	loop_02

greater_than_14:

	blt	$v0, $a1, end_loop_02

	# repeat loop ##################################
	j	error_loop_02

end_loop_02:

	# Moving integer into other register #########
	move $s1, $v0
	
	# new line ####################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# new line ####################################
	li	$v0, 4
	la	$a0, NEW_LINE
	syscall

	# calulating fine #############################
	move	$t0, $s0
	move	$t1, $s1
	sub	$s3, $s0, $s1

	# check if TIER_ZERO ##############################
	li	$t0, 0
	ble	$s3, $t0, FINE_TIER_ZERO
	j	NOT_TIER_ZERO

FINE_TIER_ZERO:

	# output TIER_ZERO ###############################
	li	$v0, 4
	la	$a0, TIER_ZERO_EXCEED_SPEED
	syscall
	j	end_program

NOT_TIER_ZERO:

	# check if TIER_ONE ##############################
	li	$t0, 20
	ble	$s3, $t0, FINE_TIER_ONE
	j	NOT_TIER_ONE

FINE_TIER_ONE:

	# output TIER_ONE ###############################
	li	$v0, 4
	la	$a0, TIER_ONE_EXCEED_SPEED
	syscall
	j	end_program

NOT_TIER_ONE:

	# check if TIER_TWO ##############################
	li	$t0, 25
	ble	$s3, $t0, FINE_TIER_TWO
	j	NOT_TIER_TWO

FINE_TIER_TWO:

	# output TIER_TWO ###############################
	li	$v0, 4
	la	$a0, TIER_TWO_EXCEED_SPEED
	syscall
	j	end_program

NOT_TIER_TWO:

	# check if TIER_THREE ##############################
	li	$t0, 34
	ble	$s3, $t0, FINE_TIER_THREE
	j	NOT_TIER_THREE

FINE_TIER_THREE:

	# output TIER_THREE ###############################
	li	$v0, 4
	la	$a0, TIER_THREE_EXCEED_SPEED
	syscall
	j	end_program

NOT_TIER_THREE:

	# TIER_FOUR #######################################
	j	FINE_TIER_FOUR

FINE_TIER_FOUR:

	# output TIER_FOUR ###############################
	li	$v0, 4
	la	$a0, TIER_FOUR_EXCEED_SPEED
	syscall
	j	end_program

end_program:

    # stop this program
    jr $31


# ENE OF LINES ######################################