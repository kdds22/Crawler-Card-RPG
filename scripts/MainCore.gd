extends Node2D


onready var pre_card_base = preload("res://scenes/CardBase.tscn")
onready var all_pos = $Cards.get_children()


#### Index das Local_Cards
onready var all_local_index = [5,6,7]




# Para cada Position2D dentro de $Cards,
# instancia uma carta base (CardBase)
func _ready() -> void:
	
	CoreSystemManager.set_distance_difficulty(5)
	
	randomize()
	for i in all_pos:
		#print(i.get_groups()) # printa o grupo do respectivo Node
		start_pre_card_base(i)

	pass # func _ready


# Inicializa as cartas nas posições pre-definidas em $Cards
# Inicializa já com atributos
func start_pre_card_base(pos_table : Position2D):
	var pos_group = str(pos_table.get_groups()[0])
	var card_base = pre_card_base.instance()
#	card_base.position = pos_table.position
	var card_config = CardManager.get_card_type_start(pos_group, pos_table.get_index(), false)

	card_base.set_card_atributes(card_config)
	card_base.add_to_group(str(pos_table.get_groups()[0]))
#	card_base.my_index_table = pos_table.get_index()
	card_base.my_info["Index"] = pos_table.get_index()

	$CardsTable.get_child(pos_table.get_index()).add_child(card_base)

	pass # func start_pre_card_base


# Chama o Gerenciador de Cartas para a proxima ação
func card_clicked(card : RigidBody2D) -> void:
	print("")
	var info = card.get_info_card() # printa a INFO da Carta
	var new_card : Array
	if info["Type"] == "Local":
		new_card = CardManager.local_card_clicked(info, card.get_parent(), info["Index"])
#		print("N O V A   C A R T A ====> ",new_card)
		for i in len(new_card):
			add_new_card(new_card[i], card.get_parent(), new_card[i]["Index"])
	
	pass # func card_clicked


# Adiciona uma Carta na Mesa -> LOCAL
func add_new_card(card : Dictionary, pos_table : Sprite, index : int):
	print()
	
	call_new_locals()
	
	if card["Type"] == "Local":
		var card_base = pre_card_base.instance()
		card_base.set_info_card(card)
#		$CardsTable.get_child(pos_table.get_index()).add_child(card_base)
#		print("Index da Nova Carta: ", card["Index"])
#		pos_table.add_child(card_base)
		$CardsTable.get_child(index).add_child(card_base)
	
	pass # func add_new_card


# Remove a Carta da Mesa
func remove_card(card : RigidBody2D) -> void:
#	if card.card_type == "Local":
	if card.my_info["Type"] == "Local":
#		card.focused = false
		card.get_parent().scale = Vector2(1,1)
		card.get_parent().self_modulate = Color(1,1,1)
		card.call_anim_out()
#		card.get_node("Anim").play("out")
#		yield(card.get_node("Anim"), "animation_finished")
	
	pass # func remove_Card



# funcao criada pra chamar Novas CARTAS-LOCAIS
func call_new_locals() -> void:
	for i in CardManager.ref_move:
		remove_card($CardsTable.get_child(CardManager.ref_move[i]["Index"]).get_child(0))
	
	pass # func call_new_locals
	
	