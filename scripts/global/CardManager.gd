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


# retorna um VECTOR2 com a IMAGEM e um NOME para um especifico tipo de Carta
func get_card_type(value : String):
	print("Tipo: "+value)
	var name = ""
	
	# Retorna a imagem de uma ARMA
	if value == "leftArm" or value == "rightArm":
		name = "ARMA"
		var image = len(image_item_weapon)
		return [image_item_weapon[int(rand_range(0,image))], name]
		
		pass # if value Arm
	
	# Retorna a imagem de um INIMIGO ou uma POCAO
	if value == "leftAction" or value == "rightAction":
		name = "AÇÃO"
		var r = int(rand_range(0,2))
		if r == 0:
			var image = len(image_action_monster)
			return [image_action_monster[int(rand_range(0,image))], name]
			
			pass # if r
		
		elif r == 1:
			var image = len(image_action_potion)
			return [image_action_potion[int(rand_range(0,image))], name]
			
			pass # elif r
		
		pass # if value Action
	
	# Retorna a imagem de um LOCAL [Floresta ou Dungeon]
	if value == "leftMove" or value == "rightMove" or value == "middleMove":
		name = "LOCAL"
		var image = len(image_local)
		return [image_local[int(rand_range(0,image))], name]
		
		pass # if value Move
	
	# Retorna a imagem do personagem [Guerreiro, Mago, Ladino], setado previamente numa variavel Global
	if value == "player":
		name = "PLAYER"
		var image = len(image_player)
		return [image_player[int(rand_range(0,image))], name]
		
		pass # if value player
	
	
	pass # func get_card_type













