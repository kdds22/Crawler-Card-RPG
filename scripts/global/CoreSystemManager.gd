extends Node

const LOCAL_MAX = 10
var local_qtd : int = 0

############# Actual Cards #############
var actual_card_local : String
############# Actual Cards #############


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


# SETa qual é a Carta de Movimentação Atual
# Contador de Local_Cards
func set_actual_local_card(value : Dictionary) -> bool:
	actual_card_local = value["Type"]
	local_qtd += 1
	if local_qtd >= LOCAL_MAX:
		local_qtd = 0
		return true
	else: return false
	pass # func set_actual_local_card
