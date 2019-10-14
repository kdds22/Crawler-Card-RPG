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
#########################################################################################################
# Armazenar Referencia da Carta Instanciada
#########################################################################################################

var ref_player
var ref_left_arm
var ref_right_arm
var ref_left_action
var ref_right_action
var ref_move = {"ref_left_move" : {}, "ref_middle_move" : {}, "ref_right_move" : {}}

#########################################################################################################
# Fim do Armazenamento da Referencia
#########################################################################################################




func _ready() -> void:
	randomize()
	
	pass # func _ready



# retorna um VECTOR2 com uma IMAGEM, o TIPO e um NOME para um especifico tipo de Carta
func get_card_type_start(value : String, index : int, change : bool):
	
	# Retorna uma ARMA
	if value == "leftArm" or value == "rightArm":
		return random_weapon(index, value, change)
		
		pass # if value Arm


	# Retorna um INIMIGO ou uma POCAO
	if value == "leftAction" or value == "rightAction":
		return random_action(index, value, change)
		
		pass # if value Action


	# Retorna um LOCAL [Floresta ou Dungeon]
	if value == "leftMove" or value == "rightMove" or value == "middleMove":
		return start_random_local(index, value, change)
		
		pass # if value Move


	# Retorna um personagem [Guerreiro, Mago, Ladino], setado previamente numa variavel Global
	if value == "player":
		return random_player(index, value, change)
		
		pass # if value player

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
	
#	print("Arma Referencias: ", ref_left_arm, " - ", ref_right_arm)
	
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
#	print("Ações Referencias: ", ref_left_action, " - ", ref_right_action)
	
	return action
	# func random_action


# Retorna um Local aleatorio INICIAL
func start_random_local(index : int, group : String, change : bool) -> Dictionary:
	
	var type := "Local"
	var name : String
	var image : String
	var description : String
	var local_chance : int
	local_chance = CoreSystemManager.get_chance()
	if local_chance < 50:
		name = "Dungeon"
		description = "Dark"
		image = image_local[0]
	elif local_chance >= 50:
		name = "Forest"
		description = "Light"
		image = image_local[1]
	
	var start_distances : Array = CoreSystemManager.start_card_distance(false, 0)
	
	var local = return_card_info(type, name, image, group, 0, description, false, Color(.05,.05,1.5,1), index, start_distances[0], start_distances[1])
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	
	match group:
		"rightMove" : ref_move["ref_right_move"] = local
		"leftMove" : ref_move["ref_left_move"] = local
		"middleMove" : ref_move["ref_middle_move"] = local
	
	print()
	
	return local
	# func start_random_local


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
	
#	print("Player Referencias: ", ref_player)
	
	return player
	# func random_player


# Retorna um Local aleatorio se puder 
func random_local(info : Dictionary, change : bool, index : int) -> Dictionary:
#func random_local(index : int, group : String, change : bool) -> Dictionary:
	
	print()
	print("Antes de continuar o Random_Local: Goal -> ",CoreSystemManager.goal_distance,", SpecialItem -> ",CoreSystemManager.special_item_distance)
	print()
	
	var type := "Local"
	var name : String
	var image : String
	var local_chance : int
	
	var distance_goal : int = CoreSystemManager.goal_distance
	var distance_special_item : int = CoreSystemManager.special_item_distance
	
	if info["Index"] == index:
		print()
		print("Focado ", info["Index"])
		print()
		if info["Distance_Goal"] > info["Distance_Special_Item"]:
			CoreSystemManager.increment_quest_distance()
			CoreSystemManager.actual_focus_distance = 0
		else:
			CoreSystemManager.increment_special_item_distance()
			CoreSystemManager.actual_focus_distance = 1
		
		distance_goal = CoreSystemManager.goal_distance
		distance_special_item = CoreSystemManager.special_item_distance
	else:
		print()
		print("Não Focado: ", info["Index"])
		print()
		var goal_item
		if info["Distance_Goal"] > info["Distance_Special_Item"]:
			goal_item = 0
		else:
			goal_item = 1
		var distance = CoreSystemManager.start_card_distance(true, goal_item)
		distance_goal = distance[0]
		distance_special_item = distance[1]
	print()
	print("Index: ",info["Index"], " - ",distance_goal, ", ", distance_special_item)
	print()
	if change:
		local_chance = CoreSystemManager.get_chance()
		if local_chance < 50:
			name = "Dungeon"
			image = image_local[0]
		elif local_chance >= 50:
			name = "Forest"
			image = image_local[1]
	else:
		name = CoreSystemManager.actual_card_local["Name"]
		image = CoreSystemManager.actual_card_local["Image"]
	
	
	
	var local = return_card_info(type, name, image, info["Group"], 0, "", false, Color(.05,.05,1.5,1), info["Index"], distance_goal, distance_special_item)
	#Tipo, Nome, Imagem, Group, Power, Description, Has_Item, Moldure_Color, Index, Distance_Goal, Distance_Special_Item
	print()
	print("random local -> ", info)
	print()
	match info["Group"]:
		"rightMove" : ref_move["ref_right_move"] = local
		"leftMove" : ref_move["ref_left_move"] = local
		"middleMove" : ref_move["ref_middle_move"] = local
	
	print()
	
	return local
	# func random_local


# Chamado ao clicar em uma Carta de Movimentação (LOCAL)
func local_card_clicked(value : Dictionary, pos_table : Sprite, index : int) -> Array:
	CoreSystemManager.set_actual_local_card(value)
	
	var return_array_local : Array = []
	var return_local : Dictionary = {}
	
	for i in ref_move:
		return_local = {}
		
		var pre_local_change = CoreSystemManager.get_local_change()
		print("Pre_local_change >>>>> ",pre_local_change)
		if pre_local_change:
#		if CoreSystemManager.set_actual_local_card(value):
			var local_or_item = CoreSystemManager.get_local_or_item()
			
			if local_or_item == "Local":
#				return_local = random_local(ref_move[i]["Index"], ref_move[i]["Group"], true)
				return_local = random_local(ref_move[i], true, index)
			elif local_or_item == "Item": # chamar um ITEM ao inves de um LOCAL (futuramente)
#				return_local = random_local(ref_move[i]["Index"], ref_move[i]["Group"], true)
				return_local = random_local(ref_move[i], true, index)
		
		else:
			value = ref_move[i]
#			return_local  = value
			return_local = random_local(ref_move[i], false, index)
#			return_local = random_local(ref_move[i]["Index"], ref_move[i]["Group"], false)
		
		return_array_local.append(return_local)
	
	print("----------------------------------------- tamanho do array_card: ", len(return_array_local))
	return return_array_local # func local_card_clicked






