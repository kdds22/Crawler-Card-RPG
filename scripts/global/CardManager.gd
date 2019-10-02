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





func _ready() -> void:
	randomize()

	pass # func _ready


# retorna um VECTOR2 com uma IMAGEM, o TIPO e um NOME para um especifico tipo de Carta
func get_card_type(value : String):

	# Retorna uma ARMA
	if value == "leftArm" or value == "rightArm":
		return random_weapon()
		pass # if value Arm

	# Retorna um INIMIGO ou uma POCAO
	if value == "leftAction" or value == "rightAction":
		return random_action()
		pass # if value Action

	# Retorna um LOCAL [Floresta ou Dungeon]
	if value == "leftMove" or value == "rightMove" or value == "middleMove":
		return random_local()
		pass # if value Move

	# Retorna um personagem [Guerreiro, Mago, Ladino], setado previamente numa variavel Global
	if value == "player":
		return random_player()
		pass # if value player

	pass # func get_card_type


#################################
# Array_Default = [Tipo, Nome, Imagem]
#################################
# Retorna uma Arma aleatoria
func random_weapon() -> Dictionary:
	var type := "Weapon"
	var name : String
	var image : String
	var weapon_chance = CoreSystemManager.get_chance()
	if weapon_chance < 50:
		name = "Bow"
		image = image_item_weapon[0]
	elif weapon_chance >= 50:
		name = "Axe"
		image = image_item_weapon[1]
	return {"Type" : type, "Name" : name, "Image" : image,
	"Power" : 0, "Distance_Goal" : 0, "Description" : "",
	"Distance_Special_Item" : 0, "Has_Item" : false, 
	"Moldure_Color" : Color(.05,1.5,.05,1), "Index" : 0}
	#pass # func random_weapon

# Retorna uma Ação (Monstro/Poção) aleatoria
func random_action() -> Dictionary:
	var type := "Action"
	var name : String
	var image : String
	var action_chance = CoreSystemManager.get_chance()
	if action_chance < 60:
		name = "Ogre"
		image = image_action_monster[0]
	elif action_chance >= 50:
		var potion_chance = CoreSystemManager.get_chance()
		if potion_chance < 50:
			name = "Moon"
			image = image_action_potion[0]
		elif potion_chance >= 50:
			name = "Sun"
			image = image_action_potion[1]
	return {"Type" : type, "Name" : name, "Image" : image, 
	"Power" : 0, "Distance_Goal" : 0, "Description" : "",
	"Distance_Special_Item" : 0, "Has_Item" : false, 
	"Moldure_Color" : Color(1.5,.05,.05,1), "Index" : 0}
	#pass # func random_action


# Retorna um Local aleatorio
func random_local() -> Dictionary:
	var type := "Local"
	var name : String
	var image : String
	var local_chance = CoreSystemManager.get_chance()
	if local_chance < 50:
		name = "Dungeon"
		image = image_local[0]
	elif local_chance >= 50:
		name = "Forest"
		image = image_local[1]
	return {"Type" : type, "Name" : name, "Image" : image, 
	"Power" : 0, "Distance_Goal" : 0, "Description" : "",
	"Distance_Special_Item" : 0, "Has_Item" : false, 
	"Moldure_Color" : Color(.05,.05,1.5,1), "Index" : 0}
	#pass # func random_local


# Retorna um Personagem Aleatório
func random_player() -> Dictionary:
	var type := "Player"
	var name : String
	var image : String
	var player_chance = CoreSystemManager.get_chance()
	if player_chance >= 0:
		name = "Warrior"
		image = image_player[0]
	return {"Type" : type, "Name" : name, "Image" : image, 
	"Power" : 0, "Distance_Goal" : 0, "Description" : "",
	"Distance_Special_Item" : 0, "Has_Item" : false, 
	"Moldure_Color" : Color(1.5,1.5,.05,1), "Index" : 0}
	#pass func random_player


# Chamado ao clicar em uma Carta de Movimentação (LOCAL)
func local_card_clicked(value : Dictionary, pos_table : Sprite) -> Dictionary:
	var return_local : Dictionary
	var pre_local_change = CoreSystemManager.set_actual_local_card(value)
	print("Pre Local Change: ",pre_local_change)
	if pre_local_change:
		var local_or_item = CoreSystemManager.get_local_or_item()
		if local_or_item == "Local":
			return_local = random_local()
		elif local_or_item == "Item": # chamar um ITEM ao inves de um LOCAL (futuramente)
			return_local = random_local()
	else:
		value["Index"] = pos_table.get_index()
		return_local = value
	print("Return Local ----> ",value["Index"], " - ", value["Image"], " - ", value["Name"])
	return return_local
#	pass # func local_card_clicked
