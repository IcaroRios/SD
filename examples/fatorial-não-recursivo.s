#############################################
# Calculo do fatorial não recusivo
# Sarah Pereira
#############################################

	addi r2,r0,0	#Numero que se quer o fatorial
	addi r3,r0,1	#Resultado
	addi r4,r0,1	#Contador
	
	
	loop: mul r3,r3,r4
		addi r4,r4,1
	
	bge r2,r4,loop
		