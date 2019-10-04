extends Node



#####  [CONSTANTES] CONTROLE IMUTAVEL DO JOGO, SERÁ USADO COMO REFERENCIA DURANTE O GAMEPLAY #####

const LOCAL_MAX = 10     # QUANTAS CARTAS-LOCAIS TERÃO DE APARECER PRA PODER "MUDAR" DE CENARIO
const GOAL_MAX = 100     # [%] PORCENTAGEM MAXIMA DO OBJETIVO DA QUEST
const SPECIAL_ITEM_MAX = 100     # [%] PORCENTAGEM MAXIMA DO ITEM ESPECIAL DA QUEST

#####  FIM DO CONTROLE IMUTAVEL #####

################################################################################################################

##### CONTROLE MUTÁVEIS DO JOGO, SERÁ USADO PRA CONTROLAR AS INFORMAÇÕES COM BASE NAS CONSTANTES #####

var local_qtd : int = 0
var goal_distance = 0
var special_item_distancE = 0

##### FIM DO CONTROLE MUTÁVEL #####

################################################################################################################

##### Actual Cards #####

var actual_card_local : Dictionary

##### Actual Cards #####





# Simula um dado de 100 lados [D100]
func get_chance() -> int:
	return int(rand_range(1,100))
	
	pass # func get_chance


# Retorna a possibilidade de ser um Cenario ou um Item
func get_local_or_item() -> String:
	if get_chance() <= 70:
		return "Local"
	else: return "Item"
	
	pass # func get_local_or_item


# SETa-GETa qual é a Carta de Movimentação Atual
func set_actual_local_card(value : Dictionary) -> void:
	actual_card_local = value
	print("actual_card_local: ",actual_card_local["Name"], 
		" ----------- ", actual_card_local["Image"], 
		" ----------- ", actual_card_local["Index"])
	
	pass
func get_local_card() -> Dictionary:
	return actual_card_local
	# func set_actual_local_card


# Contador de Local_Cards
func get_local_change() -> bool:
	local_qtd += 1
	if local_qtd >= LOCAL_MAX:
		local_qtd = 0
		return true
	else: return false
	
	pass # func get_local_change
