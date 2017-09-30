###############################################
# Example: io.s
# All inputed on UART0 is outputed on UART0
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
	#call verificarRecebimento
	#movi r2, -1
	bne r2, r8, receive		
		
	mov r4, r2
	movia r5, UART0
	call nr_uart_txchar
	#br main
		
verificarRecebimento:
	bne r2, r10, manipular

manipular: 
	subi r2, r2 ,48 
	muli r6, r6, 10
	add r6, r6,r2
	ret