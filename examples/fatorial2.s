# Calculates the N number of Fibonacci Sequence

#####Important Registers#####
# $a0 = Fibonacci Number (N)

# sp = r27
# ra = r31
# registrador $t
# v0 = r2   	#e 
# v1 = r3  	#sao para armazenar retorno de funções, r2 e r3
# a0 = r4
# a1 = r5
# a2 = r6
# a3 = r7
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
	movia r4, 5 
	call fib
	br exit

fib:					
	addi	sp, sp, -8	# Space for two words #ps ou r27			
	stw     ra, 4(sp)	# Store $ra on the stack
	mov 	r2, r4			# Here, the return value is N($a0)				
	slli	r8, r4, 2
	ble	r8, zero, fibrt	# Goes to return if N < 2 
	
			
	stw  	r4, 0(sp) 	# Save a copy of N
	addi	r4, r4, -1	# N-1
	call	fib		# fib(N-1)
			# When this line is reached, fib(N-1) is stored in $v0	
	ldw	r4, 0(sp)			
	stw	r2, 0(sp)	# Store fib(N-1) on the stack
	addi	r4, r4, -2	# N-2
	call 	fib		#fib(N-2)
			# When this line is reached, fib(N-2) is stored in $v0			
	ldw	r3, 0(sp)	#Load fib(N-1)
	add	r2, r2, r3	# fib(N-1)+fib(N-2)
	
fibrt:	
			
	ldw	ra, 4(sp)	 #Restore $ra
	addi 	sp, sp, 8	 #Restore $sp
	ret	 # Go back to caller
	
exit:	
