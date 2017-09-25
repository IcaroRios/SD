main:		
		
		movi r1, 1005			#r1 = 5 ANO (D)

		call divisivel4
		call divisivel400
		
		or r10, r6, r7
		
		br end 				#fim da rotina
		
divisivel4: #verifica se é divisivel por 4

		movi r2, 4			#r2 = 4	(d)
		div r3, r1, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 4
		mul r4, r3, r2			#r4 = r3*4 produto da divisao multiplicado pelo divisor (p*d)
		sub r4, r1, r4  		#r4 = D - (p*d) resto da divisao do ano por 4
		beq r4, r0, divisivel100 	#se r4 for igual a 0 ele executa func
				
		ret				#se nao for divisivel por 4 retorna

		
divisivel100: #verifica se não é divisivel por 100

	movi r2, 100			#r2 = 4	(d)
	div r3, r1, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 100
	mul r4, r3, r2			#r4 = r3*100 produto da divisao multiplicado pelo divisor (p*d)
	sub r4, r1, r4  		#r4 = D - (p*d) resto da divisao do ano por 100
	bne r4, r0, atribuivalorr6	#se r4 for diferente de 0 ele executa func
	
	#movi r6, 0
	
	ret				#se for divisivel por 100 retorna

atribuivalorr6:
	movi r6, 1
	ret


divisivel400: #verifica se é divisivel por 400
	
	movi r2, 400			#r2 = 4	(d)
	div r3, r1, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 400
	mul r4, r3, r2			#r4 = r3*400 produto da divisao multiplicado pelo divisor (p*d)
	sub r4, r1, r4  		#r4 = D - (p*d) resto da divisao do ano por 400
	beq r4, r0, atribuirvalorr7 	#se r4 for igual a 0 ele executa func
	
	#movi r7, 0
	
	ret
	
atribuirvalorr7:
	movi r7, 1
	ret
 
end: #Fim do programa
