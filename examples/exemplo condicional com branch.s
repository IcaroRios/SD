# Exemplo de condicional
# verifica quem � o maior, r1 ou r2, e armazena o maior valor em r3
#  -- �caro Cardoso Rios
#         16/09

main: 
	movi r1, 15 #armazena 15 em r1
	movi r2, 20 #armazena 20 em r2
	bgt r1, r2, maior #comparando se r1 � maior que r2, se verdade, vai para o branch "maior" que adiciona o valor de r1 em r3
	mov r3, r2 # s� entra aqui se a condicao acima n�o for aceita, ent�o o maior valor � r2, e ele coloca o valor de r2 em r3

	br end # fim
 
maior:
	mov r3,r1
	br end

end: 

