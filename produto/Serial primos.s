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
	addi r2, r0, 1
	movi r10, 2
	movi r3, 17
	mov r5, r0
	movi r6, 2
	mov r7, r0
	sub r4, r3, r10
	call loop

exibir:
	push r2
	addi r2, r2, 1
	br loop
	
continua:
	mov r7, r0
	ret	
loop:
	blt r4, r5, end
	cmpeqi r7, r10, 2
	call loopInterno
	movi r6, 2
	addi r5, r5, 1
	beq r7, r2, exibir
	addi r10, r10, 1
	br loop
	
loopInterno:
	bge r6, r10, return
	restoDivisao r10, r6, r9
	beq r9, r0, continua
	movi r7, 1
	addi r6, r6, 1
	br loopInterno
	
return:
	ret

end:
