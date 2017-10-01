.data
.equ UART0, 0x860

.global main
.text

.macro push reg
	subi sp, sp, 4
	stw \reg, 0(sp)
.endm

.macro pop reg
	ldw \reg, 0(sp)
	addi sp, sp, 4
.endm

.macro restoDivisao operadorA, operadorB, resto
	div \resto, \operadorA, \operadorB
	mul \resto, \resto, \operadorB
	sub \resto, \operadorA, \resto
.endm


main:
	mov r6, r0# este irá ficar acumulando o valor que eu desejo.
	movi r8, 10#constante enter #também sera a constante para divisao
	movi r10, -1 #constante -1
	mov r15, r0 #meus valores a serem exibidos na serial
	mov r11,r0 #resto
	
	br receive

receive:
	movia r4, UART0		
	call nr_uart_rxchar
	#aqui eu já recebi uma informação serial, então subtraí 48 para pegar o decimal dele
	call verificarRecebimento
	#movi r2, -1
	ble r2, r0, receive

	br receive

#VERIFICA SE O VALOR FOI DIFERENTE DE -1
verificarRecebimento:
	beq r2, r8, bissexto
	bne r2, r10, manipular
	ret

# SE O VALOR É DIFERENTE DE -1, ELE SUBTRAI 48 DO NÚMERO
# MULTIPLICA R6 POR 10
# SOMA A R6 O VALOR RECEBIDO DA SERIAL
manipular: 
	subi r2, r2 ,48 
	muli r6, r6, 10
	add r6, r6,r2
	ret
	
bissexto:		
		
		#movi r6, 2012		#r1 = 5 ANO (D) #valor que quero calcular se é bissexto

		call divisivel4
		call divisivel400
		
		or r10, r5, r7
		addi r5, r5, 48
		mov r4, r5
		movia r5, UART0
		call nr_uart_txchar
		br end 				#fim da rotina
		
divisivel4: #verifica se é divisivel por 4

		movi r2, 4			#r2 = 4	(d)
		div r3, r6, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 4
		mul r4, r3, r2			#r4 = r3*4 produto da divisao multiplicado pelo divisor (p*d)
		sub r4, r6, r4  		#r4 = D - (p*d) resto da divisao do ano por 4
		beq r4, r0, divisivel100 	#se r4 for igual a 0 ele executa func
				
		ret				#se nao for divisivel por 4 retorna

		
divisivel100: #verifica se não é divisivel por 100

	movi r2, 100			#r2 = 4	(d)
	div r3, r6, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 100
	mul r4, r3, r2			#r4 = r3*100 produto da divisao multiplicado pelo divisor (p*d)
	sub r4, r6, r4  		#r4 = D - (p*d) resto da divisao do ano por 100
	bne r4, r0, atribuivalorr6	#se r4 for diferente de 0 ele executa func
	
	#movi r6, 0
	
	ret				#se for divisivel por 100 retorna

atribuivalorr6:
	movi r5, 1
	ret


divisivel400: #verifica se é divisivel por 400
	
	movi r2, 400			#r2 = 4	(d)
	div r3, r1, r2			#r3 = r1/r2 (p) resultado da divisao do ano por 400
	mul r4, r3, r2			#r4 = r3*400 produto da divisao multiplicado pelo divisor (p*d)
	sub r4, r6, r4  		#r4 = D - (p*d) resto da divisao do ano por 400
	beq r4, r0, atribuirvalorr7 	#se r4 for igual a 0 ele executa func
	
	#movi r7, 0
	
	ret
	
atribuirvalorr7:
	movi r7, 1
	ret
 
end: #Fim do programa
	.end
