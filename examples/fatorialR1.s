.macro push reg
	subi sp, sp, 4
	stw \reg, 0(sp)
.endm

.macro pop reg
	ldw \reg, 0(sp)
	addi sp, sp, 4
.endm

main:	
	
	addi r2,r0,5	#Numero que se quer o fatorial
	addi r4,r0,1	#deixar como 1
	mov r6, r2	#parametro inicializado com o 5
	
	push r6   	#R6 colocando parametro na pilha	
	mov r5, r0 #variavel #variavel para ser usada dentro das funcoes
	call fatorial
		
	br end
	
	
fatorial:
	pop r5	
	push ra
	call compara	#faz a comparação do caso base
	pop ra
	call else	#fazer a comparação inversa do caso base
	ret
compara:
	push ra
	ble r5, r4, executa # SE R5(PARAMETRO) FOR MENOR QUE R4(1), CHAMA EXECUTA	
	ret

executa:	
	push r4 #COLOCOU O R4 NA PILHA
	ret
	
end:
	.end
