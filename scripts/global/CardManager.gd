extends Node

onready var image_local = ["res://assets/local/dungeon_1.png",
							"res://assets/local/forest_1.png"]
onready var image_action_monster = ["res://assets/inimigo/monstro_1.png"]
onready var image_action_potion = ["res://assets/pocao/pocao_lua_1.png",
									"res://assets/pocao/pocao_sol_1.png"]
onready var image_item_weapon = ["res://assets/arma/arco.png",
									"res://assets/arma/machado.png"]

func _ready() -> void:
	randomize()
	get_card_type("rightArm")
	
	pass # func _ready


# retorna uma IMAGEM para um especifico tipo de Carta
func get_card_type(value : String):
	print("Tipo: "+value)
	# Retorna a imagem de uma ARMA
	if value == "leftArm" or value == "rightArm":
		var image = len(image_item_weapon)
		return image_item_weapon[int(rand_range(0,image))]
		
		pass # if value
	
	# Retorna a imagem de um INIMIGO ou uma POCAO
	if value == "leftAction" or value == "rightAction":
		var r = int(rand_range(0,2))
		if r == 0:
			var image = len(image_action_monster)
			return image_action_monster[int(rand_range(0,image))]
			
			pass # if r
		
		elif r == 1:
			var image = len(image_action_potion)
			return image_action_potion[int(rand_range(0,image))]
			
			pass # elif r
		
		pass # if value
	
	# Retorna a imagem de um LOCAL [Floresta ou Dungeon]
	if value == "leftMove" or value == "rightMove" or value == "middleMove":
		var image = len(image_local)
		return image_local[int(rand_range(0,image))]
		
		pass # if value
		
	pass # func get_card_type













