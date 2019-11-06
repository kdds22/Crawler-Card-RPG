extends Node


#########################################################################################################
# Pré-Carregamento
#########################################################################################################

onready var image_player = ["res://assets/player/warrior_1.png"]
onready var image_local = ["res://assets/local/dungeon_1.png",
							"res://assets/local/forest_1.png"]
onready var image_action_monster = ["res://assets/inimigo/monstro_1.png"]
onready var image_action_potion = ["res://assets/pocao/pocao_lua_1.png",
									"res://assets/pocao/pocao_sol_1.png"]
onready var image_item_weapon = ["res://assets/arma/arco.png",
									"res://assets/arma/machado.png"]

#########################################################################################################
# Fim do Pré-Carregamento
#########################################################################################################


#########################################################################################################
# Armazenar Referencia da Carta Instanciada
#########################################################################################################

var ref_player # referencia da carta-player
var ref_left_arm # referencia da mão-esquerda do player
var ref_right_arm # referencia da mão-direita do player
var ref_left_action # referencia da carta-ação (meio) a esquerda
var ref_right_action # referencia da carta-açõa (meio) a direita
# referencia das cartas-locais (cima)
var ref_move = {"ref_leftMove" : {}, "ref_middleMove" : {}, "ref_rightMove" : {}}

#########################################################################################################
# Fim do Armazenamento da Referencia
#########################################################################################################


#########################################################################################################
# Referencia da Interoperabilidade das Cartas ESCOLHIDAS
#########################################################################################################

var card_clicked : RigidBody2D # carta-clicada 
var card_released : RigidBody2D # com qual carta a carta-clicada irá interagir

var _on_card_interacting : RigidBody2D

var interaction : bool = false # se haverá ou não interação entre Cartas

# LOCAL-DIRECTION
# TRUE = GOAL; FALSE = ITEM
var direction_move = {"leftMove_direction" : true, "rightMove_direction" : true, "middleMove_direction" : true}

#########################################################################################################
# Fim da Referencia da Interoperabilidade das Cartas ESCOLHIDAS
#########################################################################################################



func _ready() -> void:
	randomize()
	CoreSystemManager.turn = true # Turno do Jogador
	
	pass # func _ready


# LIMPA a Interoperabilidade entre as cartas
func clear_maked() -> void:
	card_clicked = null # limpa a carta-clicada
	card_released = null # limpa a carta-"soltada"-released
	
	pass # func clear_maked


# retorna um tipo (dicionario) de uma carta
func get_card_type_start(value : String, index : int, change : bool):
	
	match value:
		"leftArm": # Retorna uma ARMA
			return random_weapon(index, value, change)
			
		"rightArm": # Retorna uma ARMA
			return random_weapon(index, value, change)
			
		"leftAction": # Retorna um INIMIGO ou uma POCAO
			return random_action(index, value, change)
			
		"rightAction": # Retorna um INIMIGO ou uma POCAO
			return random_action(index, value, change)
			
		"leftMove": # Retorna um LOCAL [Floresta ou Dungeon]
			return start_random_local(index, value, change)
			
		"rightMove": # Retorna um LOCAL [Floresta ou Dungeon]
			return start_random_local(index, value, change)
			
		"middleMove": # Retorna um LOCAL [Floresta ou Dungeon]
			return start_random_local(index, value, change)
			
		"player": # Retorna um personagem [Guerreiro, Mago, Ladino], setado previamente numa variavel Global
			return random_player(index, value, change)
	
	pass # func get_card_type



##################################################################
# Array_Default = [Tipo, Nome, Imagem, Group, Power, Distance_Goal,
#					Description, Distance_Special_Item, Has_Item
#					Moldure_Color, Index]
##################################################################
func return_card_info(Type : String, Name : String, Imagem : String, Group : String, 
	Power : int, Description : String, Has_Item : bool, Moldure_Color : Color, 
	Index : int, Distance_Goal : int, Distance_Special_Item : int) -> Dictionary:
	
	return {"Type" : Type, "Name" : Name, "Image" : Imagem, "Group" : Group,
	"Power" : Power, "Description" : Description, "Has_Item" : Has_Item, 
	"Moldure_Color" : Moldure_Color, "Index" : Index,
	"Distance_Goal" : Distance_Goal, "Distance_Special_Item" : Distance_Special_Item}

##################################################################
##################################################################


# Retorna uma Arma aleatoria
func random_weapon(index : int, group : String, change : bool) -> Dictionary:
	var type := "Weapon"
	var name : String
	var image : String
	var description : String
	var weapon_chance = CoreSystemManager.get_chance()
	if weapon_chance < 50:
		name = "Bow"
		description = "Long"
		image = image_item_weapon[0]
	elif weapon_chance >= 50:
		name = "Axe"
		description = "Short"
		image = image_item_weapon[1]
	
	var weapon = return_card_info(type, name, image, group, 0, description, false, Color(.05,1.5,.05,1), index, 0, 0)
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	match group:
		"leftArm" : ref_left_arm = weapon
		"rightArm" : ref_right_arm = weapon
	
	return weapon
	# func random_weapon


# Retorna uma Ação (Monstro/Poção) aleatoria
func random_action(index : int, group : String, change : bool) -> Dictionary:
	var type := "Action"
	var name : String
	var image : String
	var action_chance = CoreSystemManager.get_chance()
	var description : String
	if action_chance < 60:
		name = "Ogre"
		description = "Enemy"
		image = image_action_monster[0]
	elif action_chance >= 60:
		var potion_chance = CoreSystemManager.get_chance()
		description = "Potion"
		if potion_chance < 50:
			name = "Moon"
			image = image_action_potion[0]
		elif potion_chance >= 50:
			name = "Sun"
			image = image_action_potion[1]
	
	var action = return_card_info(type, name, image, group, 0, description, false, Color(1.5,.05,.05,1), index, 0, 0)
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	match group:
		"leftAction" : ref_left_action = action
		"rightAction" : ref_right_action = action
	print()
	
	return action
	# func random_action


# Retorna um Local aleatorio INICIAL
func start_random_local(index : int, group : String, change : bool) -> Dictionary:
	
	var type := "Local"
	var name : String
	var image : String
	var description : String
	var local_chance : int
	var direction_start : bool
	
	local_chance = CoreSystemManager.get_chance()
	if local_chance < 50:
		name = "Dungeon"
		description = "Dark"
		image = image_local[0]
	elif local_chance >= 50:
		name = "Forest"
		description = "Light"
		image = image_local[1]
	
	var goal_item = CoreSystemManager.start_local_card_goal_item() # Armazena o contador inicial das direções -> [0] = GOAL, [1] = SPECIAL_ITEM
	print(goal_item," -> startado")
	if goal_item[0] > goal_item[1]:
		direction_start = true
	else:
		direction_start = false
		
	
	var local = return_card_info(type, name, image, group, 0, description, false, Color(.05,.05,1.5,1), index, goal_item[0], goal_item[1])
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	ref_move["ref_"+group] = local
	direction_move[group+"_direction"] = direction_start
	
	print()
	
	return local
	# func start_random_local



# Retorna um Local aleatorio se puder 
# O CHANGE serve pra indicar se virá um novo tipo de LOCAL
func random_local(info : Dictionary, change : bool, index : int) -> Dictionary:
	print("\n\nChange RANDOM_LOCAL: ",change," - Index: ",index,"\n\n")
	var name : String
	var image : String
	var local_chance : int # chance de mudança de ambiente, se puder
	
	var goal_distance = CoreSystemManager.goal_distance
	var special_item_distance = CoreSystemManager.special_item_distance
	
	# Mantem a direção da carta ESCOLHIDA e aumenta o contador especifico
	if index == info["Index"]:
		print("----------->",info["Distance_Goal"], info["Distance_Special_Item"])
		var distance = CoreSystemManager.increment_decrement_distance_card_local(info["Distance_Goal"], info["Distance_Special_Item"])
		goal_distance = distance[0]
		special_item_distance = distance[1]
		direction_move[info["Group"]+"_direction"] = distance[2]
		#parei aqui!
		print("\n\n\nDistance: ",distance[2]," - ",direction_move[info["Group"]+"_direction"])
#		var direction = CoreSystemManager.get_chance()
#		if direction >= 50:
		if distance[2]:
			get_node("/root/MainCore/CoreDirection/HSlider").value += CoreSystemManager.actual_distance_difficulty
		else:
			get_node("/root/MainCore/CoreDirection/HSlider").value -= CoreSystemManager.actual_distance_difficulty
			
		
	else:
		var distance = CoreSystemManager.increment_decrement_distance_card_local(CoreSystemManager.actual_card_local["Distance_Goal"], CoreSystemManager.actual_card_local["Distance_Special_Item"])
		goal_distance = distance[0]
		special_item_distance = distance[1]
		direction_move[info["Group"]+"_direction"] = CoreSystemManager.get_goal_or_specialItem()
	
	if change: # se o ambiente mudar
		local_chance = CoreSystemManager.get_chance()
		if local_chance < 50:
			name = "Dungeon"
			image = image_local[0]
		elif local_chance >= 50:
			name = "Forest"
			image = image_local[1]
	else: # se o ambiente continuar imutavel
		name = CoreSystemManager.actual_card_local["Name"]
		image = CoreSystemManager.actual_card_local["Image"]
	
	var local = return_card_info("Local", name, image, info["Group"], 0, "", false, Color(.05,.05,1.5,1), info["Index"], goal_distance, special_item_distance)
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	
	# Armazenar uma referencia da NOVA carta-local, por grupo
	ref_move["ref_"+info["Group"]] = local
	
	return local
	# func random_local



# Retorna um Personagem Aleatório
func random_player(index : int, group : String, change : bool) -> Dictionary:
	var type := "Player"
	var name : String
	var image : String
	var description : String
	var player_chance = CoreSystemManager.get_chance()
	if player_chance >= 0:
		name = "Warrior"
		description = "Melee"
		image = image_player[0]
	
	var player = return_card_info(type, name, image, group, 0, description, false, Color(1.5,1.5,.05,1), index, 0, 0)
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	ref_player = player
	
	print()
	
	return player
	# func random_player



# Chamado ao clicar em uma Carta de Movimentação (LOCAL)
func local_card_clicked(value : Dictionary, pos_table : Sprite, index : int) -> Array:
	CoreSystemManager.set_actual_local_card(value)
	
	var return_array_local : Array = []
	var return_local : Dictionary = {}
	
	for i in ref_move:
		return_local = {}
		
		var pre_local_change = CoreSystemManager.get_local_change() # se poderá mudar de ambiente
		var local_or_item = CoreSystemManager.get_local_or_item() # se a proxima carta será um ambiente ou um item
		
		if pre_local_change:
			if local_or_item == "Local":
				return_local = random_local(ref_move[i], true, index)
			elif local_or_item == "Item": # chamar um ITEM ao inves de um LOCAL (futuramente)
				return_local = random_local(ref_move[i], true, index)
		else:
			if local_or_item == "Local":
				return_local = random_local(ref_move[i], false, index)
			elif local_or_item == "Item": # chamar um ITEM ao inves de um LOCAL (futuramente)
				return_local = random_local(ref_move[i], false, index)
		
		return_array_local.append(return_local)
		
	return return_array_local # func local_card_clicked






