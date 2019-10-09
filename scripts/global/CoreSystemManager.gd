extends Node



#####  [CONSTANTES] CONTROLE IMUTAVEL DO JOGO, SERÁ USADO COMO REFERENCIA DURANTE O GAMEPLAY #####

const LOCAL_MAX : int = 10     # QUANTAS CARTAS-LOCAIS TERÃO DE APARECER PRA PODER "MUDAR" DE CENARIO
const GOAL_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO OBJETIVO DA QUEST
const SPECIAL_ITEM_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO ITEM ESPECIAL DA QUEST

#####  FIM DO CONTROLE IMUTAVEL #####

################################################################################################################

##### CONTROLE MUTÁVEIS DO JOGO, SERÁ USADO PRA CONTROLAR AS INFORMAÇÕES COM BASE NAS CONSTANTES #####

var local_qtd : int = 0
var goal_distance : int = 0
var special_item_distance : int = 0
var actual_distance_difficulty : int = 0

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


# Usado pra escolher qual a dificuldade da QUEST escolhida
func set_distance_difficulty(value : int) -> void:
	actual_distance_difficulty = value
	
	pass # func set_distance_difficulty


# Aproxima o jogador do Objetivo da Quest
func increment_quest_distance() -> void:
	goal_distance += actual_distance_difficulty
	special_item_distance -= actual_distance_difficulty
	if special_item_distance <= 0:
		special_item_distance = 0
	
	pass # func increment_quest_distance


# Aproxima o jogador de um Item Especial existente na QUest
func increment_special_item_distance() -> void:
	special_item_distance += actual_distance_difficulty
	goal_distance -= actual_distance_difficulty
	if goal_distance <= 0:
		goal_distance = 0
	
	pass # func increment_special_item_distance


# Inicializa valores para
func start_card_distance() -> Array:
	if get_chance() <= 50:
		goal_distance = 51
		special_item_distance = 49
	else:
		special_item_distance = 51
		goal_distance = 49
	return [goal_distance, special_item_distance]