extends Node


var local_qtd : int = 0

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
