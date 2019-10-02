extends Node2D


onready var pre_card_base = preload("res://scenes/CardBase.tscn")
onready var all_pos = $Cards.get_children()

#### Index das Local_Cards
onready var all_local_index = [5,6,7]

# Para cada Position2D dentro de $Cards,
# instancia uma carta base (CardBase)
func _ready() -> void:
	randomize()
	for i in all_pos:
		#print(i.get_groups()) # printa o grupo do respectivo Node
		start_pre_card_base(i)

	pass # func _ready


# Inicializa as cartas nas posições pre-definidas em $Cards
# Inicializa já com atributos
func start_pre_card_base(pos_table : Position2D):
	var card_base = pre_card_base.instance()
#	card_base.position = pos_table.position
	var card_config = CardManager.get_card_type(str(pos_table.get_groups()[0]))
	print("Card Config: ",card_config["Name"], " - ", card_config["Index"])

	card_base.set_card_atributes(card_config)
	card_base.add_to_group(str(pos_table.get_groups()[0]))
	card_base.my_index_table = pos_table.get_index()

	$CardsTable.get_child(pos_table.get_index()).add_child(card_base)

	pass # func start_pre_card_base


# Chama o Gerenciador de Cartas para a proxima ação
func card_clicked(card : RigidBody2D) -> void:
	print("")
	print("")
	var info = card.get_info_card() # printa a INFO da Carta
	print("Info Card Clicked: ",info["Name"], info["Image"], card.get_parent())
	var new_card : Dictionary
	if info["Type"] == "Local":
		new_card = CardManager.local_card_clicked(info, card.get_parent())
		add_new_card(new_card, card.get_parent())
		remove_card(card)
		print("Nova Carta: ", new_card["Name"], " - ", new_card["Image"])
	
	pass # func card_clicked


# Adiciona uma Carta na Mesa
func add_new_card(card : Dictionary, pos_table : Sprite):
	print("Add New Card: ",card["Type"], "-", card["Name"], "-", card["Image"])
	if card["Type"] == "Local":
		print("Pos Table: ",pos_table)
		var card_base = pre_card_base.instance()
		card_base.set_info_card(card)
#		$CardsTable.get_child(pos_table.get_index()).add_child(card_base)
		pos_table.add_child(card_base)
		print("Card Base INFO: ", card_base.get_info_card()["Name"], " - ",card_base.get_info_card()["Image"])
	pass # func add_new_card


# Remove a Carta da Mesa
func remove_card(card : RigidBody2D) -> void:
	if card.card_type == "Local":
		card.focused = false
		card.get_parent().scale = Vector2(1,1)
		card.get_parent().self_modulate = Color(1,1,1)
		card.queue_free()
	
	pass # func remove_Card