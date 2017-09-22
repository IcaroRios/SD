.macro push reg
	subi sp, sp, 4
	stw \reg, 0(sp)
.endm

.macro pop reg
	ldw \reg, 0(sp)
	addi sp, sp, 4
.endm

main:
	call teste
	br end
teste:
	push ra
	call teste2
	pop ra
	ret
teste2:
	ret

end:
	.end