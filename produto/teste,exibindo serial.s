#####################################################################
# example.s: Program for test1
#####################################################################

.macro push reg
	subi sp, sp, 4
	stw \reg, 0(sp)
.endm

.macro pop reg
	ldw \reg, 0(sp)
	addi sp, sp, 4
.endm

.data
.equ UART0, 0x860
.text

.macro restoDivisao operadorA, operadorB, resto
	div \resto, \operadorA, \operadorB
	mul \resto, \resto, \operadorB
	sub \resto, \operadorA, \resto
.endm

.global main

main:	
	movi r5,509 #valor que quero exibir
	movi r8, 10 #constante para divisão
	mov r11,r0 #resto
	mov r15, r0 #meus valores a serem exibidos
	call exibir
	br end
	
exibir:
	beq r5, r0, return
	push ra
	restoDivisao r5,r8, r11
	div r5, r5, r8
	push r11
	#bne r5 ,r0 ,exibir
	call exibir
	pop r15
	
	addi r15, r15, 48
	mov r4, r15
	movia r15, UART0
	call nr_uart_txchar
	
	pop ra
	ret
return:
	ret
end:
 .end
