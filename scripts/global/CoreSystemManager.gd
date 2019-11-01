extends Node



#####  [CONSTANTES] CONTROLE IMUTAVEL DO JOGO, SERÁ USADO COMO REFERENCIA DURANTE O GAMEPLAY #####

const LOCAL_MAX : int = 10     # QUANTAS CARTAS-LOCAIS TERÃO DE APARECER PRA PODER "MUDAR" DE CENARIO
const GOAL_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO OBJETIVO DA QUEST
const SPECIAL_ITEM_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO ITEM ESPECIAL DA QUEST

#####  FIM DO CONTROLE IMUTAVEL #####

################################################################################################################

##### CONTROLE MUTÁVEIS DO JOGO, SERÁ USADO PRA CONTROLAR AS INFORMAÇÕES COM BASE NAS CONSTANTES #####

export var local_qtd : int = 0
export var goal_distance : int = 0
export var special_item_distance : int = 0
export var actual_distance_difficulty : int = 0

export var actual_focus_distance : int = 0 # 0 = Goal , 1 = Special_Item


export var player_hp : int = 10
export var weapon_damage : int = 5
export var potion_cure : int = 5
export var enemy_hp : int = 10
export var enemy_atk : int = 2

##### FIM DO CONTROLE MUTÁVEL #####

################################################################################################################

##### Actual Cards #####

export var actual_card_local : Dictionary

##### Actual Cards #####

var turn : bool = false # Flag do turno Player-Sistema
var process : bool = true # Flag de ação do Player




# Simula um dado de 100 lados [D100]
func get_chance() -> int:
	return int(rand_range(1,100))
	
	pass # func get_chance


# GETa a direção para o Objetivo ou Item Especial
func get_goal_or_specialItem() -> int:
	if get_chance() <= 50:
		actual_focus_distance = 1
	else: actual_focus_distance = 0
	
	return actual_focus_distance # func get_goal_or_specialItem


# Retorna a possibilidade de ser um Cenario ou um Item
func get_local_or_item() -> String:
	if get_chance() <= 70:
		return "Local"
	else: return "Item"
	
	pass # func get_local_or_item


# SETa-GETa qual é a Carta de Movimentação Atual
func set_actual_local_card(value : Dictionary) -> void:
	actual_card_local = value
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