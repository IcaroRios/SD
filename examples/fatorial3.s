# Calculates the N number of Fibonacci Sequence

#####Important Registers#####
# $a0 = Fibonacci Number (N)

main:		
	movia r4, 10
	movia r15,1	
	call fibrt
	br exit

fib:	
	blt	r4, r15 , fibrt	# Goes to return if N < 1 
	mov 	r8, r4
	ret
fibrt:					
	subi	sp, sp, 12	# Space for two words #ps ou r27			
	stw     ra, 0(sp)	# Store $ra on the stack
	stw  	r2, 4(sp) 	# Save a copy of N
	mov 	r2, r4		# Here, the return value is N($a0)	
	
	addi	r4, r4, -1	# N-1
	call	fib		# fib(N-1)	
	stw  	r8, 8(sp) 	# Save a copy of N
		
	addi	r4, r2, -2	# N-2
	call 	fib		#fib(N-2)	
	ldw	r10, 8(sp)		
	add	r8, r10, r8		
		
	ldw	r2, 4(sp)	
	ldw	ra, 0(sp)	
	addi	sp, sp, 12
	ret
	
	
	
	
exit:	
