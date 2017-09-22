# Calculates the N number of Fibonacci Sequence

#####Important Registers#####
# $a0 = Fibonacci Number (N)

.equ N, 5


# sp = r27
# ra = r31
# v0 = r2   	#e 
# v1 = r3  	#sao para armazenar retorno de funções, r2 e r3
# a0 = r4
# registrador $t
# r8 t0
# r9 t1
# r10 t2
# r11 t3
# r12 t4
# r13 t5
# r14 t6
# r15 t7
# int fib(int n): return n < 2 ? n : fib(n-1) + fib(n-2)

main:		
	movia r4, 5 # N = 5
	call fib
	br exit

fib:	
				#addi	sp, sp, -8		# Space for two words #ps ou r27
	addi	sp, sp, -8	
				#sw	ra, 4(sp)			# Store $ra on the stack
	stw     ra, 4(sp)	
	mov 	r2, r4			# Here, the return value is N($a0)
				#slti	r8, r1, 2
	slli	r8, r4, 2
	ble	r8, zero, fibrt	# Goes to return if N < 2 ##É BNE OU BLE?
			#sw	r1, 0(sp)			# Save a copy of N
	stw  	r1, 0(sp)
	addi	r1, r1, -1		# N-1
	call	fib					# fib(N-1)
			# When this line is reached, fib(N-1) is stored in $v0
	#lw	r4, 0(sp)
	ldw	r4, 0(sp)
	#sw	r2, 0(sp)			# Store fib(N-1) on the stack
	stw	r4, 0(sp)
	addi	r4, r4, -2		# N-2
	call 	fib					# fib(N-2)
			# When this line is reached, fib(N-2) is stored in $v0
	#lw	r3, 0(sp)			# Load fib(N-1)
	ldw	r3, 0(sp)
	add	r2, r2, r3		# fib(N-1)+fib(N-2)
	
fibrt:	
	#lw 	ra, 4(sp)			# Restore $ra
	ldw	ra, 4(sp)
	addi sp, sp, 8			# Restore $sp
	#br ra					# Go back to caller
	ret
exit:	
