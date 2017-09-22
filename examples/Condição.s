# Teste condicional que volta para o mesmo ponto
#  -- Ícaro Cardoso Rios

main: 
	movi r2, 5 #armazena 5 em r1
	movi r5 ,1 #armazena 1 em r5
	movi r3 ,0 #armaenando 0 em r
	call subRotina #chama o
	movi r2,15
	br end # fim
 
subRotina:
	ble  r3, r5, executarRetornar # se esta condicao for atendida ele chama executarRtornar,
	#que irá executar o que foi desejado e irá voltar para o local que foi chamado,	
	ret#caso contrário, ele vai voltar para a linha : "call subRotina"

executarRetornar:
	movi r3,10 #armazena 10 em r3
	ret #volta para a linha que tem o "call subRotina"
	
end: 

