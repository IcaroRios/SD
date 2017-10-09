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
	#mov r11, r11# este irá ficar acumulando o valor que eu desejo.
	movi r8, 10 #constante enter #também sera a constante para divisao
	movi r10, -1 #constante -1
	mov r15,r0 #resto
	############################
	#movi r14, 10
	#call exibir #o que deve ser exibido
	#br end
	############################	
	br receive
	
	
receive:
	movia r4, UART0		
	call nr_uart_rxchar
	#aqui eu já recebi uma informação serial, então subtraí 48 para pegar o decimal dele
	call verificarRecebimento
	#movi r2, -1
	ble r2, r0, receive

	br receive

verificarRecebimento:
	beq r2, r8, inicio
	bne r2, r10, manipular
	ret

# SE O VALOR É DIFERENTE DE -1, ELE SUBTRAI 48 DO NÚMERO
# MULTIPLICA R6 POR 10
# SOMA A R6 O VALOR RECEBIDO DA SERIAL
manipular: 
	subi r2, r2 ,48 
	muli r11, r11, 10
	add r11, r11,r2
	ret
	
inicio:
	#br end
	#movi r11,5 #r11 está dizendo o valor que será computado.
	movi r16,1
	movi r7, 1

for:
	bge r11, r7, start
	br end

start:
	movi r3, 1
	mov r9, r0
	push r7
	call fibonacci
	mov r14, r9
	call exibir #o que deve ser exibido
	####EXIBINDO A VIRGULA NA SERIAL
	movi r12, 44
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	#####
	
	addi r7, r7, 1
	br for
	
fibonacci:
	pop r16
	bgt r16, r3, else
	add r9, r9, r16
	ret

else:
	push ra
	subi r6, r16, 1
	push r6
	subi r6, r6, 1
	push r6
	call fibonacci
	call fibonacci
	pop ra
	ret	
	
exibir:################################################################
	
	beq r14, r0, return
	push ra
	restoDivisao r14,r8, r15
	div r14, r14, r8
	push r15
	call exibir
	pop r12
	
	addi r12, r12, 48
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	
	#movi r12, 44
	#mov r4, r12
	#movia r12, UART0
	#call nr_uart_txchar
	
	pop ra
	ret
	
	
return:
	ret
end:
	.end
