.data
.equ UART0, 0x860

.global main

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

array: 		
		.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		.text

main:
	movia r19, array			#chama o vetor
	
	mov r6, r0# este irá ficar acumulando o valor que eu desejo.
	movi r8, 10#constante enter #também sera a constante para divisao
	movi r10, -1 #constante -1
	mov r15, r0 #meus valores a serem exibidos na serial
	movi r23, 44
	mov r11,r0 #resto
	br receive
	br end

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
	beq r2, r8, tamanho ################# COLOCAR PARA VIRGULA
	beq r2, r23, virgula
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


tamanho:
	mov r18, r6
	mov r16,r18
	subi r17,r18,1
	movi r6,0
	br receive

virgula:
	
	subi r16, r16, 1
	stw r6,0(r19)	
	movi r6,0
	beq r16, r0, iniciar
	addi r19, r19, 4

	br receive
	
iniciar:	
		#br end##############################################TESTE
		movia r19, array			#chama o vetor
		movi r12, 1			#inicializando i = 1 primeiro contador
		movi r16, 0			#inicializando j = 0 segundo contador

		#br end



firstLoop:	
		movia r19, array			#chama o vetor
		blt r12, r18, secondLoop		#compara se o contador i é menor que o tamanho do vetor se sim, vai pro 
						#loop2, se não termina.
		
		
		
		movi r16, 0	#inicializando i = 1 primeiro contador
		movia r19, array			#chama o vetor
		br exibir		
		br end
exibir:		
	#call exibirSerial
	addi r16, r16,1
	ldw r5, 0(r19)	
	call exibirSerial
	
	movi r12, 44
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	
	addi r19,r19,4
	blt r16,r18, exibir
	br end

exibirSerial:
	beq r5, r0, return
	push ra
	restoDivisao r5,r8, r11
	div r5, r5, r8
	push r11
	call exibirSerial
	pop r12
	
	addi r12, r12, 48
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	
	pop ra
	ret

secondLoop:			
		blt r16, r17, se			#confere se j é menor que tamanho do vetor - 1	
		addi r12, r12, 1			#incrementa o i
		mov r16, r0			#zera o j
		br firstLoop			#chama o incial

se:		
		ldw r20, 0(r19)			#armazera o vetor em r8
		ldw r9, 4(r19)			#armazera a proxima casa do vetor em r9
		addi r16,r16, 1			#incrementa o j
			
		
		bgt r20, r9, bubble		#confere se o vetor é menor que a proxima casa
		addi r19,r19, 4			#incrementa posição do vetor 
		br secondLoop			

bubble:  	
		ldw r21, 0(r19) # j		#armazena em r10 o elemento do vetor[j]
		ldw r22, 4(r19) # j +1		#armazena em r11 o elemento do vetor[j+1]
		stw r21, 4(r19)			#coloca o valor do vetor[j+1] em r10
		stw r22, 0(r19)			#coloca o valor de vetor[j] em r11 -- Fim do swap
		addi r19,r19, 4			#incrementa posição do vetor
		br secondLoop

return:
	ret
	
end:
		.end