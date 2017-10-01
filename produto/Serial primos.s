.global main
.data
.equ UART0, 0x860
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
	mov r9,r0# irá acumular o segundo valor que desejo
	mov r6, r0# este irá ficar acumulando o segundo valor que eu desejo.
	movi r8, 10#constante enter #também sera a constante para divisao
	movi r10, -1 #constante -1
	mov r12, r0 #meus valores a serem exibidos na serial
	mov r11,r0 #resto
	#call primo
	br receivePrimeiro
	br end
	
receivePrimeiro:
	movia r4, UART0		
	call nr_uart_rxchar
	#aqui eu já recebi uma informação serial, então subtraí 48 para pegar o decimal dele
	call verificarRecebimentoPrimeiro
	ble r2, r0, receivePrimeiro
	br receivePrimeiro

verificarRecebimentoPrimeiro:
	beq r2, r8, receiveSegundo
	bne r2, r10, manipularPrimeiro
	ret

manipularPrimeiro: 
	subi r2, r2 ,48 
	muli r9, r9, 10
	add r20, r20,r2
	ret

receiveSegundo:
	movia r4, UART0		
	call nr_uart_rxchar
	#aqui eu já recebi uma informação serial, então subtraí 48 para pegar o decimal dele
	call verificarRecebimento
	ble r2, r0, receiveSegundo

	br receiveSegundo
	

	
verificarRecebimento:
	beq r2, r8, primo
	bne r2, r10, manipular
	ret

manipular: 
	subi r2, r2 ,48 
	muli r6, r6, 10
	add r6, r6,r2
	ret
	
primo:
	#movi r13, 2
	#movi r14, 13
	movi r16, 0
	movi r17, 2
	movi r18, 0
	movi r19, 1
	#sub r15, r14, r13	
	sub r15, r6, r20

		
loop1:
	blt r15, r16, end
	#cmpeqi r18, r13, 2
	cmpeqi r18, r20, 2
	call loop2
	movi r17, 2
	addi r16, r16, 1
	beq r18, r19, print
	#addi r13, r13, 1
	addi r20, r20, 1
	br loop1
	
loop2:
	#bge r17, r13, endloop2
	bge r17, r20, endloop2
	#restoDivisao r13, r17, r9
	restoDivisao r20, r17, r9
	beq r9, r0, else
	movi r18, 1
	addi r17, r17, 1
	br loop2
	
endloop2:
	ret

else:
	movi r18, 0
	ret
print:
	#push r13 #devo exibir os valores aqui.
	mov r5,r20
	call exibir
	movi r12, 44
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	addi r20, r20, 1
	br loop1

exibir:
	beq r5, r0, return
	push ra
	restoDivisao r5,r8, r11
	div r5, r5, r8
	push r11
	#bne r5 ,r0 ,exibir
	call exibir
	pop r12
	
	addi r12, r12, 48
	mov r4, r12
	movia r12, UART0
	call nr_uart_txchar
	
	pop ra
	ret

return:
	ret
end:
	.end
