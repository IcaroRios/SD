# Exemplo de condicional
# verifica quem é o maior, r1 ou r2, e armazena 1 em r3 se a condicao for verdadeira
#  -- Ícaro Cardoso Rios
#         16/09

main: 
	movi r1, 15 #armazena 15 em r1
	movi r2, 20 #armazena 20 em r2
	cmpgt r3, r1, r2 ##comparacoes do tipo cmpgt compara se um registrador1 é maior que o  r2 e armazena 1 em r3 caso seja verdade
	#comparacoes tipo cmpeg(comparacao tipo ==)
	cmpeqi r5, r3,0	
	br end # fim
 
end: 