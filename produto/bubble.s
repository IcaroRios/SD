		.data
array: 		
		.word 8, 6, 3, 9, 5, 4, 3, 2, 7
		.text

main:		
		movi r4, 1		#inicializando i = 1
		movi r5, 0		#inicializando j = 0
		movi r6, 9		#numero(n) de elementos do vetor 9 
		movi r7, 8		#n-1  8	

firstLoop:	
		movia r3, array		#chama o vetor
		blt r4, r6, secondLoop
		br end
		
secondLoop:			
		blt r5, r7, se
		addi r4, r4, 1
		mov r5, r0
		br firstLoop

se:		
		ldw r8, 0(r3)
		ldw r9, 4(r3)
		addi r5,r5, 1
		
		
		bgt r8, r9, bubble
		addi r3,r3, 4
		br secondLoop

bubble:  	
		ldw r10, 0(r3) # j
		ldw r11, 4(r3) # j +1
		stw r10, 4(r3)
		stw r11, 0(r3)
		addi r3,r3, 4
		br secondLoop
		
end:
		.end
