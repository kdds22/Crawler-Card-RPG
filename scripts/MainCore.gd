extends Node2D


onready var pre_card_base = preload("res://scenes/CardBase.tscn")
onready var all_pos = $Cards.get_children()


var ref_player : Object

var enemy : bool = false # flag de já foi instanciado um Inimigo
var potion : bool = false # flag de já foi instanciado uma Poção



# Para cada Position2D dentro de $Cards,
# instancia uma carta base (CardBase)
func _ready() -> void:	
	randomize()
	for i in all_pos:
		start_pre_card_base(i)

	pass # func _ready


# Inicializa as cartas nas posições pre-definidas em $Cards
# Inicializa já com atributos
func start_pre_card_base(pos_table : Position2D):
	
	var pos_group = str(pos_table.get_groups()[0])
	var card_base = pre_card_base.instance()
	
	var card_config = CardManager.get_card_type_start(pos_group, pos_table.get_index(), false)
	card_base.set_card_atributes(card_config)
	card_base.add_to_group(str(pos_table.get_groups()[0]))
	card_base.my_info["Index"] = pos_table.get_index()
	# não pode vir 2 cartas do mesmo Action_Type (ex.: 2 ogros, ou 2 poções)
	while (card_config["Description"] == "Enemy" and enemy == true) or (card_config["Description"] == "Potion" and potion == true):
		card_config = CardManager.get_card_type_start(pos_group, pos_table.get_index(), false)
		card_base.set_card_atributes(card_config)
		card_base.add_to_group(str(pos_table.get_groups()[0]))
		card_base.my_info["Index"] = pos_table.get_index()

	$CardsTable.get_child(pos_table.get_index()).add_child(card_base)
	
	if card_base.my_info["Type"] == "Player":
		ref_player = card_base # seta a referencia do Objeto-Player... mantendo todos os atributos pra facilitar conexões
	if card_base.my_info["Description"] == "Enemy":
		enemy = true
	if card_base.my_info["Description"] == "Potion":
		potion = true
		
	pass # func start_pre_card_base


# Chama o Gerenciador de Cartas para a proxima ação
# Põe na Tela as proximas 3 Cartas-Locais
func card_clicked(card : RigidBody2D) -> void:
	var info = card.get_info_card() # printa a INFO da Carta
	var new_card : Array
	if info["Type"] == "Local":
		new_card = CardManager.local_card_clicked(info, card.get_parent(), info["Index"])
		for i in len(new_card):
			add_new_card(new_card[i], card.get_parent(), new_card[i]["Index"])
	
	pass # func card_clicked


# Adiciona uma Carta na Mesa -> LOCAL
func add_new_card(card : Dictionary, pos_table : Sprite, index : int):
	
	call_new_locals()
	
	if card["Type"] == "Local":
		var card_base = pre_card_base.instance()
		card_base.set_info_card(card)
		
		$CardsTable.get_child(index).add_child(card_base)
	
	pass # func add_new_card


# Remove a Carta da Mesa
func remove_card(card : RigidBody2D) -> void:
	if card.my_info["Type"] == "Local":
		card.get_parent().scale = Vector2(1,1)
		card.get_parent().self_modulate = Color(1,1,1)
		card.call_anim_out()
	
	pass # func remove_Card



# funcao criada pra chamar Novas CARTAS-LOCAIS
func call_new_locals() -> void:
	for i in CardManager.ref_move:
		remove_card($CardsTable.get_child(CardManager.ref_move[i]["Index"]).get_child(0))
	
	pass # func call_new_locals
	
	