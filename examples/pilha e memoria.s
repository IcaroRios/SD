#####################################################################
# example.s: Program for test1
#####################################################################

.data
A: .word 0
B: .word 0
C: .word 0

.text
MOVIA r8, A 		#address A copied to reg r8
LDW r9, 0(r8) 		#value A copied to reg r9
MOVIA r8, B 		#address B copied to reg r8
LDW r10, 0(r8) 		#val#####################################################################

	.data
var:	.word 5

	.macro PUSH reg		# Macro for PUSH
	addi sp, sp, -4
	stw \reg, 0(sp)
	.endm

	.macro POP reg		# Macro for POP
	ldw \reg, 0(sp)
	addi sp, sp, 4
	.endm

	.global main

	.text
main:	movia	r8, var		# Move adress of variable var to r8
	ldw	r9, 0(r8)	# Move value of variable var to r9
	addi	r9, r9, 2	# Add 2 to value of r9
	stw	r9, 0(r8)	# Move value of r8 to variable var

	PUSH r9			# pushes r9 on stack
	POP r10			# pops stack and puts it in r10
				# If r9 equals r10 this will work
				# Also verify that sp has same value before PUSH as after POPue B copied to reg r10
ADD r11, r9, r10 	#r11 <= r9 + r10
MOVIA r8, C 		#address C copied to reg r8
STW r11, 0(r8) 		#result in r11 copied
			        #to memory on address C