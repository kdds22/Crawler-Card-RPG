extends Node2D


onready var all_pos = $"..".get_node("Cards").get_children()
onready var pre_card_moldura = preload("res://scenes/CardSlot.tscn")


func _ready() -> void:
	for i in all_pos:
		var card_moldura = pre_card_moldura.instance()
		card_moldura.position = i.position
		card_moldura.name = i.name
		add_child(card_moldura)
		
		pass
	
	pass # Replace with function body.

