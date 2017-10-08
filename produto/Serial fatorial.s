###############################################
#RECEBIMENTO SERIAL ATÉ CHEGAR O ENTER
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
	mov r12, r0 #meus valores a serem exibidos na serial
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
	beq r2, r8, iniciarFatorial
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
	
iniciarFatorial:	
	movi r2,1	#const
	#movi r4, 5
	call fatorial
		
	call exibir
	
	br end
	
fatorial:
	bge r2 ,r6, return1
	push ra
	push r6
	subi r6 ,r6,1
	call fatorial
	pop r6
	pop ra
	mul r5 ,r5, r6
	ret

exibir:
	beq r5, r0, return
	push ra
	restoDivisao r5,r8, r11
	div r5, r5, r8
	push r11
	call exibir
	pop r12
	
	addi r12, r12, 48
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	
	pop ra
	ret

return1:
	movi r5,1
	ret
return:
	ret
end:
	.end
	
