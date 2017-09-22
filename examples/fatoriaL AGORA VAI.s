.macro push reg
	subi sp, sp, 4
	stw \reg, 0(sp)
.endm

.macro pop reg
	ldw \reg, 0(sp)
	addi sp, sp, 4
.endm

main:	
	movi r2,1	#const
	movi r4, 5
	call fatorial
		
	br end
	
fatorial:
	bge r2 ,r4, return1
	push ra
	push r4
	subi r4 ,r4,1
	call fatorial
	pop r4
	pop ra
	mul r5 ,r5, r4
	ret

return1:
	movi r5,1
	ret
	
end:
	.end
