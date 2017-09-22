# Exemplo loopback na UART0
# -- Havallon Azevedo
#         16/09 
    
.equ UART0RX, 0x860 # Endereço da RxData do UART0 na memoria
.equ UART0TX, 0x864 # Endereço da TxData do UART0 na memoria
.equ RxReady, 0x868 # Endereço de memoria para a flag RxReady

.global main

main:
	movia r1, UART0RX # r1 como ponteiro para RxData do UART0
	movia r2, RxReady # r2 como ponteiro para flag RxReady
	movia r3, UART0TX # r3 como ponteiro para TxData do UART0
	
loopback:
	ldw r4, 0(r2)
	andi r4, r4, 128
	beq r4, r0, loopback
	ldw r4, 0(r1)
	stw r4, 0 (r3)
	br loopback