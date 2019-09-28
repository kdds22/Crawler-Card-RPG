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
# Pré-Chamada
#########################################################################################################

onready var card_local_dungeon = {"Image" : image_local[0], "Type" : "Local", "Name" : "Masmorra"}
onready var card_local_forest = {"Image" : image_local[1], "Type" : "Local", "Name" : "Floresta"}
onready var card_monster_ogre = {"Image" : image_action_monster[0], "Type" : "Ação", "Name" : "Ogro"}
onready var card_potion_moon = {"Image" : image_action_potion[0], "Type" : "Ação", "Name" : "Poção Lunar"}
onready var card_potion_sun = {"Image" : image_action_potion[1], "Type" : "Ação", "Name" : "Poção Solar"}
onready var card_weapon_bow = {"Image" : image_item_weapon[0], "Type" : "Arma", "Name" : "Arco e Flecha"}
onready var card_weapon_axe = {"Image" : image_item_weapon[1], "Type" : "Arma", "Name" : "Machado"}
onready var card_player_warrior = {"Image" : image_player[0], "Type" : "Player", "Name" : "Guerreiro"}

#########################################################################################################
# Fim da Pré-Chamada
#########################################################################################################




func _ready() -> void:
	randomize()
	
	pass # func _ready


# retorna um VECTOR2 com a IMAGEM e um NOME para um especifico tipo de Carta
func get_card_type(value : String):
#	print("Tipo: "+value)
	
	# Retorna a imagem de uma ARMA
	if value == "leftArm" or value == "rightArm":
		var weapon = CoreSystemManager.random_weapon()
		match weapon:
			"Bow":
				return card_weapon_bow
			"Axe":
				return card_weapon_axe
		
		pass # if value Arm
	
	# Retorna a imagem de um INIMIGO ou uma POCAO
	if value == "leftAction" or value == "rightAction":
		var action = CoreSystemManager.random_action()
		match action:
			"Ogre":
				return card_monster_ogre
			"Moon":
				return card_potion_moon
			"Sun":
				return card_potion_sun
		
		pass # if value Action
	
	# Retorna a imagem de um LOCAL [Floresta ou Dungeon]
	if value == "leftMove" or value == "rightMove" or value == "middleMove":
		var local = CoreSystemManager.random_local()
		match local:
			"Dungeon":
				return card_local_dungeon
			"Forest":
				return card_local_forest
		
		pass # if value Move
	
	# Retorna a imagem do personagem [Guerreiro, Mago, Ladino], setado previamente numa variavel Global
	if value == "player":
		return card_player_warrior
		
		pass # if value player
	
	
	pass # func get_card_type













