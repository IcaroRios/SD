# Teste fatorial recursivo
#  -- Ícaro Cardoso Rios

main: 
	movi r2, 5 #armazena 5 em r1
	movi r5 ,1 #deixar como valor dpara parada
	movi r3,0 #usar como temporario	
	call fatorial
	movi r2,15
	br end # fim
 
fatorial:
	ble  r3, r5, retornar
	ret
	#call retornar # o ret funciona bem com o call más não com o ble

retornar:
	movi r2,10
	ret
	
end: 

