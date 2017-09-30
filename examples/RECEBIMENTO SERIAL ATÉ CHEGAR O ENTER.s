###############################################
#RECEBIMENTO SERIAL AT� CHEGAR O ENTER
###############################################

.data
.equ UART0, 0x860

.global main
.text

main:		
mov r6, r0# este ir� ficar acumulando o valor que eu desejo.
movi r8, 10#constante enter
movi r10, -1
br receive

receive:
	movia r4, UART0		
	call nr_uart_rxchar
	#aqui eu j� recebi uma informa��o serial, ent�o subtra� 48 para pegar o decimal dele
	call verificarRecebimento
	#movi r2, -1
	ble r2, r0, receive
		
	#mov r4, r2
	#movia r5, UART0
	#call nr_uart_txchar
	br receive

#VERIFICA SE O VALOR FOI DIFERENTE DE -1
verificarRecebimento:
	beq r2, r8, end
	bne r2, r10, manipular

	ret

# SE O VALOR � DIFERENTE DE -1, ELE SUBTRAI 48 DO N�MERO
# MULTIPLICA R6 POR 10
# SOMA A R6 O VALOR RECEBIDO DA SERIAL
manipular: 
	subi r2, r2 ,48 
	muli r6, r6, 10
	add r6, r6,r2
	ret
	
end:
	
