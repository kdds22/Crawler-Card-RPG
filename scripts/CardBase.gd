extends RigidBody2D


var pre_heal = preload("res://scenes/HealEffect.tscn")

# =====================================================
# Propriedade das Cartas
# =====================================================

var my_info : Dictionary = {}

var card_info_interacting : RigidBody2D

# =====================================================
# Fim da Propriedade das Cartas
# =====================================================

var main_core_path = "../../.."

var initial_position : Vector2
var global_initial_position : Vector2

var focused := false # usado pra indicar uma carta
var clicked := false # usado como um FLAG de clique unico
var moving := false 
var handling := false

var count_cards_calls : int = 0

var interactin_flag_clicked : bool = false
var interactin_flag_n_clicked : bool = false



# PEGA todas as informações da Carta
# Retorna um dicionario de atributos
func get_info_card() -> Dictionary:
	return my_info  # func get_info_card


# SETar todos os atributos para a nova carta
# Dicionario -> Local_Variaveis
func set_info_card(card : Dictionary) -> void:
	my_info = card #reaproveitar script pra calculos extras
	set_card_atributes(my_info)
	
	pass # func set_info_card


# LIMPA todos os atributos da carta
func clean_info_card() -> void:
	my_info = {}
	
	pass # func clean_info_card


# Função pra Executar qualquer ação de "entrada" sobre a carta
# Normalmente ações com o Mouse
func _unhandled_input(event: InputEvent) -> void:
	if CoreSystemManager.turn: # verifica se está no turno do Jogador
		if focused:
			if event.is_action_pressed("click"):
				match my_info["Type"]: # Verificação dos Tipos de carta... like StateMachine
					
					"Local":
						get_node(main_core_path).card_clicked(self)
					
					_: # MATCH/SWITCH DEFAULT
						clicked = true
						$Sprite.z_index = 1
				
				## Mudar no Mapa
				
			if event.is_action_released("click"):
				moving = false
				position = initial_position
				$Sprite.z_index = 0
				if clicked:
					clicked = false
					$Sprite.z_index = 0
					position = initial_position
					focused = false
					# Manter o SLOT da Carta-Arma ATIVADO?????????????? testar pra verificar ... 
#																							get_parent().scale = Vector2(1.1,1.1)
#																							get_parent().self_modulate = Color(1,1,1)
					if CardManager._on_card_interacting != null:
						_on_interacting_card()
					else:
						print("\n\n_unhandled_input > if event.is_action_released(click) > if clicked > else CardManager._on_card_interacting != null \n\n")
					
				else:
					print("_unhandled_input > if event.is_action_released(click) : ",my_info["Name"], ", interação - ", clicked)
	
	
		if clicked and event is InputEventMouseMotion:
			if my_info["Type"] == "Weapon":
				moving = true
			if my_info["Type"] == "Action" and my_info["Description"] == "Potion":
				moving = true
	else: # verifica se esta no turno do sistema / inimigos / npc
		system_turn()
		
	
	pass # func _input


# Chamado ao Instanciar uma Carta
func _ready() -> void:
	# TODO: seilah... só um exemplo!
	get_node(main_core_path).connect("system_turn", self, "system_turn")
	
	global_initial_position = global_position
	initial_position = position
	
	if my_info["Type"] == "Local":
		$Sprite/TextureProgressGoal.value = my_info["Distance_Goal"]
		$Sprite/TextureProgressItem.value = my_info["Distance_Special_Item"]
		
		if CardManager.direction_move[my_info["Group"]+"_direction"]:
			$Sprite/TextureProgressGoal/Anim.play("signal")
		else:
			$Sprite/TextureProgressItem/Anim.play("signal")

	pass # func _ready


func _process(delta: float) -> void:
	if moving:
		global_position = get_global_mouse_position()
		clicked = true # sem isso a carta não realiza a interação, por causa da condição -> if clicked and not focused:
	pass



# SETa TODAS as informações/atributos da Carta
# Chamando todas as funções individuais pra cada atributo
func set_card_atributes(value : Dictionary) -> void:
	set_name_type(value["Type"])
	set_image_type(value["Image"])
	set_name_desc(value["Name"])
	set_description(value["Description"])
	set_card_group(value["Group"])
	set_card_index(value["Index"])
	set_card_distance_goal(value["Distance_Goal"])
	set_card_distance_special_item(value["Distance_Special_Item"])
	
	pass # func set_card_atributes


# SETa-GETa as distancias do Objetivo e de Itens Especiais
func set_card_distance_goal(value : int) -> void:
	my_info["Distance_Goal"] = value
func get_card_distance_goal() -> int:
	return my_info["Distance_Goal"]
###################################################
func set_card_distance_special_item(value : int) -> void:
	my_info["Distance_Special_Item"] = value
func get_card_distance_special_item() -> int:
	return my_info["Distance_Special_Item"]
# func SET-GET card_distance - goal/special_item


#SETa o INDEX (do "parent") correspondente na MESA
func set_card_index(value : int):
	my_info["Index"] = value
	
	pass # func set_card_index


#SETa um grupo a Carta
func set_card_group(value : String) -> void:
	if not value == null:
		add_to_group(value)
		my_info["Group"] = value
	pass # func set_card_group


#SET-GET do TIPO da Carta
func set_name_type(value : String) -> void:
	my_info["Type"] = value
	$Sprite/NameType.text = value
	set_cristais(value)
func get_name_type() -> String:
	return $Sprite/NameType.text


#SETagem da IMAGEM da Carta
func set_image_type(value) -> void:
	my_info["Image"] = value
	if value != "Null":
		$Sprite/ImageType.texture = load(value)
	else: 
		print(value + " CardBase_set_image_type")

	pass # func set_image_type


#SETagem do NOME da Carta
func set_name_desc(value : String) -> void:
	my_info["Name"] = value
	$Sprite/NameDesc.text = value
	
	pass # func set_name_desc


#SETagem da DESCRICAO da Carta
func set_description(value : String) -> void:
	my_info["Description"] = value
	
	pass # func set_description


#SETagem dos CRISTAIS da Carta
func set_cristais(value : String) -> void:
	match value:
		"Action":
			cristal_rect(Rect2(16,0,16,16), Rect2(16,16,16,16)) # vermelho
			my_info["Moldure_Color"] = Color(1.5,.05,.05,255)
		"Weapon":
			cristal_rect(Rect2(32,0,16,16), Rect2(32,16,16,16)) # verde
			my_info["Moldure_Color"] = Color(.05,1.5,.05,1)
		"Local":
			cristal_rect(Rect2(0,0,16,16), Rect2(0,16,16,16)) # azul
			my_info["Moldure_Color"] = Color(.05,.05,1.5,1)
		"Player":
			cristal_rect(Rect2(48,0,16,16), Rect2(48,16,16,16)) # amarelo
			my_info["Moldure_Color"] = Color(1.5,1.5,.05,1)

	pass # func set_cristais


#Define a REGION da SPRITE dos cristais/joias -> CardBase
func cristal_rect(rect2_mini : Rect2, rect2_big : Rect2) -> void:
	$Sprite/CristalMini.region_rect = rect2_mini
	$Sprite/CristalBig.region_rect = rect2_big

	pass # func cristal_rect



# Referencia a Carta que esta sendo FOCADA
func _on_CardBase_mouse_entered() -> void:
	if CoreSystemManager.process:
		focused = true
		get_parent().scale = Vector2(1.2,1.2)
		get_parent().self_modulate = my_info["Moldure_Color"]
	
	pass # func _on_CardBase_mouse_entered


# Referencia a Carta que esta sendo "DES"FOCADA
func _on_CardBase_mouse_exited() -> void:
	if CoreSystemManager.process:
		if not moving:
			focused = false
			clicked = false
			get_parent().scale = Vector2(1.1,1.1)
			get_parent().self_modulate = Color(1,1,1)
	
	pass # func _on_CardBase_mouse_exited


# Ativa uma ANIMAÇÂO de IN-OUT na carta, prestes a ser excluida do jogo
func call_anim_out() -> void:
	if focused:
		$Anim.play("out")
	else:
		$Anim.play("out_2")
	
	pass # func call_anim_out


# Chama a animação de HIT_DAMAGE na Carta
func call_anim_hit() -> void:
	$Anim.play("hit")
	
	pass # func call_anim_hit


# Altera a possibilidade de poder clicar na carta
func pickable(value : bool) -> void:
	input_pickable = value
	
	pass # func pickable


# ACIONA a Interação com a Carta-Escolhida
func _on_interacting_card() -> void:
	var _on_card = CardManager._on_card_interacting
	if my_info["Type"] == "Weapon" and _on_card.my_info["Type"] == "Action" and _on_card.my_info["Name"] == "Ogre":
		CoreSystemManager.turn = false
		_on_card.call_anim_hit()
		_on_card._show_card_points(CoreSystemManager.weapon_damage, "hit")
		pass
	if my_info["Type"] == "Action" and my_info["Description"] == "Potion" and _on_card.my_info["Type"] == "Player":
		CoreSystemManager.turn = true
		_on_card.heal(CoreSystemManager.potion_cure)
		pass
	pass # func _on_interacting_card


# DETECTA de um Corpo ENTROU ou SAIU
func _on_Detect_body_entered(body: PhysicsBody2D) -> void:
	if body != self and clicked: # and body.focused:
		print("Entrou em: ",body.my_info["Name"], " -> ",self.my_info["Name"], ", Modo: ",body.mode)
	pass

func _on_Detect_body_exited(body: PhysicsBody2D) -> void:
	if body != self and body.focused: # and body.focused:
		print("Saiu de: ",body.my_info["Name"], " -> ",self.my_info["Name"])
		card_info_interacting = null
	pass # Replace with function body.


# O SISTEMA Usa o que tiver a disposição pra ATACAR o PLAYER, no caso, os inimigos.... por enquanto
func atk_player() -> void:
	$Tween.interpolate_property(self, "global_position", global_position, get_node("/root/MainCore").ref_player.global_position, .5, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()
	yield($Tween,"tween_completed")
	get_node("/root/MainCore").ref_player.call_anim_hit()
	get_node("/root/MainCore").ref_player._show_card_points(CoreSystemManager.enemy_atk, "hit")
	$Tween.interpolate_property(self, "position", position, initial_position, .5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	clicked = false
	focused = false
	get_parent().scale = Vector2(1.1,1.1)
	get_parent().self_modulate = Color(1,1,1)
	$Sprite.z_index = 0
	turn_on_player(true)
	pass # func atk_player


# Metodo pra CURAR o Player (atualmente, só por poção)
func heal(value) -> void:
	var heal = pre_heal.instance()
	add_child(heal)
	_show_card_points(value, "heal")
	pass # func heal


# Função de AÇÂO Básica do SISTEMA
func system_turn() -> void:
	if my_info["Type"] == "Action" and my_info["Description"] == "Enemy":
		turn_on_player(false)
		yield(get_tree().create_timer(1, false),"timeout")
		count_cards_calls += 1
		atk_player()
	else:
		count_cards_calls += 1 # contagem do total de cartas (que não seja inimigo)
	
	if count_cards_calls >= 4: # minimo de 4 cartas pra voltar o turno do jogador 
		turn_on_player(true)
		count_cards_calls = 0
		get_node(main_core_path).turn_on()
	
	pass

# Metodo chamado quando os TWEENs do Sistema terminarem e dá a vez/turno ao Jogador
func _on_Tween_tween_all_completed() -> void:
	
	$Tween.stop_all()
	turn_on_player(true)
	
	pass # func _on_Tween_tween_all_completed


# Declara TURNO do Jogador
func turn_on_player(value : bool) -> void:
	CoreSystemManager.turn = value
	set_process_unhandled_input(value)
	CoreSystemManager.process = value
	
	pass # func turn_on_player


func _show_card_points(value : int, type : String) -> void:
	$Number/Value.text = str(value)
	$Number.show()
	match type:
		"hit":
			$Number/AnimationPlayer.play("hit")
		"heal":
			$Number/AnimationPlayer.play("heal")
		_:
			print("func _show_card_points... value: ",value," e type: ",type)
	pass
	