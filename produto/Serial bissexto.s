###############################################
# Example: bissexto.s
# verificar se ano eh bissexto
###############################################

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
	#call iniciar
	
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
	beq r2, r8, iniciar
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
	
	
	
iniciar:
	#movi r11, 2000 		#declaracao do ano #####
	movi r12, 400		#declaracao divisor 400
	movi r16, 4		#declaracao divisor 4
	movi r7, 100		#declaracao divisor 100
	
	div r8, r6, r12		#dividindo ano por 400 e analisando o resto
	mul r9, r8, r12
	sub r9, r6, r9
	
	beq r9, r0, finalVerdadeiro	#retornos para o registrador 10
	bne r9, r0, retornoFalso
	
retornoFalso:
	div r8, r6, r16		#dividindo ano por 4 e analisando resto
	mul r9, r8, r16
	sub r9, r6, r9
	
	beq r9, r0, divisaoPorCem	#ultimo passo
	bne r9, r0, finalFalso		#ano nao eh bissexto

divisaoPorCem:
	div r8, r1, r7 		#dividindo ano por 100 e analisando resto
	mul r9, r8, r7
	sub r9, r1, r9
	
	beq r9, r0, finalFalso
	bne r9, r0, finalVerdadeiro

finalVerdadeiro:
	movi r13, 1 ##############
	addi r13, r13, 48
	mov r4, r13
	movia r5, UART0
	call nr_uart_txchar
	call end
	
finalFalso:
	movi r13, 0
	addi r13, r13, 48
	mov r4, r13
	movia r13, UART0
	call nr_uart_txchar
	call end
	
end:
	br end