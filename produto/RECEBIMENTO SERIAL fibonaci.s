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

main:
	mov r6, r0# este irá ficar acumulando o valor que eu desejo.
	movi r8, 10#constante enter
	movi r10, -1
	
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
	
	#AS LINHAS COMENTADAS ABAIXO FAZEM A EXIBIÇÃO DE R5 NA SERIAL, MÁS DE APENAS UM CARACTERE.
	# É PRECISO SEPARAR OS CARACTERES PARA COLOCAR UM POR UM PARA SEREM EXIBIDOS.
	#addi r5, r5, 48
	#mov r4, r5
	#movia r5, UART0
	#call nr_uart_txchar
	
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

return1:
	movi r5,1
	ret
	
end:
	.end
	
