extends Node



#####  [CONSTANTES] CONTROLE IMUTAVEL DO JOGO, SERÁ USADO COMO REFERENCIA DURANTE O GAMEPLAY #####

const LOCAL_MAX : int = 10     # QUANTAS CARTAS-LOCAIS TERÃO DE APARECER PRA PODER "MUDAR" DE CENARIO
const GOAL_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO OBJETIVO DA QUEST
const SPECIAL_ITEM_MAX : int = 100     # [%] PORCENTAGEM MAXIMA DO ITEM ESPECIAL DA QUEST

#####  FIM DO CONTROLE IMUTAVEL #####

################################################################################################################

##### CONTROLE MUTÁVEIS DO JOGO, SERÁ USADO PRA CONTROLAR AS INFORMAÇÕES COM BASE NAS CONSTANTES #####

var local_qtd : int = 0 # quantidade de cartas-locais de um mesmo tipo

var goal_distance : int = 0 # distancia para o objetivo da quest em relação ao GOAL_MAX
var special_item_distance : int = 0 # distancia para o item especial da quest em relação ao SPECIAL_ITEM_MAX

var actual_distance_difficulty : int = 0 # "dificuldade" da quest... o quão dificil é chegar nos "..._MAX"

var actual_focus_distance : bool = true # true = Goal , false = Special_Item

###
# valores iniciais (para testes de balanceamento basico)
export var player_hp : int = 10
export var weapon_damage : int = 5
export var potion_cure : int = 5
export var enemy_hp : int = 10
export var enemy_atk : int = 2

##### FIM DO CONTROLE MUTÁVEL #####

################################################################################################################

##### Actual Cards #####

var actual_card_local : Dictionary # carta-local escolhida

##### Actual Cards #####

var turn : bool = false # Flag do turno Player-Sistema
var process : bool = true # Flag de ação do Player




# Simula um dado de 100 lados [D100]
func get_chance() -> int:
	return int(rand_range(1,100))
	
	pass # func get_chance


# GETa a direção para o Objetivo ou Item Especial
func get_goal_or_specialItem() -> bool:
	if get_chance() <= 50:
		actual_focus_distance = false
	else: actual_focus_distance = true
	
	return actual_focus_distance # func get_goal_or_specialItem


# RETORNA um contador INICIAL para as cartas-locais startadas
func start_local_card_goal_item() -> Array:
	var chance = get_chance()
	if chance >= 50:
		return [actual_distance_difficulty, 0]
	else:
		return [0, actual_distance_difficulty]
	
	# func start_local_card_goal_item


# RETORNA novos valores para os contadores, INCREMENTANDO ou DECREMENTANDO
func increment_decrement_distance_card_local(goal, item, dir) -> Array:
	var direction : bool
	if dir:
		goal_distance = goal + actual_distance_difficulty
		special_item_distance = item - actual_distance_difficulty
		direction = true
	else:
		goal_distance = goal - actual_distance_difficulty
		special_item_distance = item + actual_distance_difficulty
		direction = false
	
	return [goal_distance, special_item_distance, direction]
	
	# return func increment_decrement_distance_card_local


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
