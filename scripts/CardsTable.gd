extends Node


onready var all_pos = $"..".get_node("Cards").get_children()
onready var pre_card_moldura = preload("res://scenes/CardSlot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in all_pos:
		var card_moldura = pre_card_moldura.instance()
		card_moldura.position = i.position
		add_child(card_moldura)
		print("Nome da Moldura: "+card_moldura.name)
		pass
	
	pass # Replace with function body.

