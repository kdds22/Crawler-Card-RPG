extends Node2D


onready var pre_card_base = preload("res://scenes/CardBase.tscn") 
onready var all_pos = $Cards.get_children()


# Para cada Position2D dentro de $Cards,
# instancia uma carta base (CardBase)
func _ready() -> void:
	randomize()
	for i in all_pos:
		#print(i.get_groups()) # printa o grupo do respectivo Node
		start_pre_card_base(i)
	
	pass # func _ready


# Inicializa as cartas nas posições pre-definidas em $Cards
func start_pre_card_base(pos_table : Position2D):
	var card_base = pre_card_base.instance()
	card_base.position = pos_table.position
	var image = CardManager.get_card_type(str(pos_table.get_groups()[0]))
	card_base.set_image_type(str(image))
	$CardsTable.add_child(card_base)
	
	pass # func start_pre_card_base




