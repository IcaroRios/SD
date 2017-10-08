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
	br inicio
	
inicio:
	
	movi r2,6 #r2 está dizendo o valor que será computado.
	movi r5,1
	movi r8, 1

while:
	bge r2, r8, start
	br end

start:
	movi r3, 1
	mov r4, r0
	push r8
	call fibonacci
	call sending #o que deve ser exibido
	addi r8, r8, 1
	br while
	
fibonacci:
	pop r5
	bgt r5, r3, do
	add r4, r4, r5
	ret

do:
	push ra
	subi r6, r5, 1
	push r6
	subi r6, r6, 1
	push r6
	call fibonacci
	call fibonacci
	pop ra
	ret	
	
sending:################################################################
	mov r14, r4
	ret

end:
	.end
