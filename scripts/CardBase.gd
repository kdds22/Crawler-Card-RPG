extends RigidBody2D


# =====================================================
# Propriedade das Cartas
# =====================================================

var my_info : Dictionary = {}

# =====================================================
# Fim da Propriedade das Cartas
# =====================================================

var main_core_path = "../../.."

var initial_position : Vector2

var focused := false # usado pra indicar uma carta
var clicked := false # usado como um FLAG de clique unico
var moving := false 
var handling := false


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
	
	if focused and event is InputEventMouseButton:
		
		
		if event.is_action_pressed("click"):
			if clicked:
				print("is_pressed_clicked...")
			else:
				clicked = true
				z_index = 1
				print("is_pressed_Not_clicked...")
				if my_info["Type"] == "Local":
						get_node(main_core_path).card_clicked(self) # MainCore.gd
			
			
			print(my_info["Type"])
		
		if event.is_action_released("click"):
			if clicked:
				clicked = false
				z_index = 0
				position = initial_position
				print("is_released_clicked... escolhi a carta: ", my_info["Name"])
			else:
				print("is_released_Not_clicked... e vai interagir com: ", my_info["Name"])
			
#			print(my_info["Name"])
		
		pass
	
	
	
	
	"""
	if event is InputEventMouseButton:
		if event.is_action_pressed("click"):
			if focused:
				if not clicked:
					if my_info["Type"] == "Action":
						print("Carta de AÇÃO -> ",my_info["Name"])
						if my_info["Description"] == "Potion":
							clicked = true
							z_index = 1
					if my_info["Type"] == "Weapon":
						clicked = true
						z_index = 1
		if event.is_action_released("click"):
			if focused:
				if clicked:
					print("Clicked...")
					if my_info["Type"] == "Weapon":
						CardManager.card_clicked = self
				elif not clicked:
					print("Not Clicked...")
					if my_info["Type"] == "Action" and my_info["Description"] == "Enemy" and CardManager.card_clicked != null:
						CardManager.card_released = self
				
				CardManager.make_interaction()
			
			position = initial_position
			clicked = false
			focused = false
			z_index = 0
			"""
	if clicked and event is InputEventMouseMotion:
		if my_info["Type"] == "Weapon":
			moving = true
			global_position = get_global_mouse_position()
		if my_info["Type"] == "Action" and my_info["Description"] == "Potion":
			moving = true
			global_position = get_global_mouse_position()
		moving = false
	
	pass # func _input


# Chamado ao Instanciar uma Carta
func _ready() -> void:
	pickable(false)
	$Sprite/TextureProgressGoal.value = my_info["Distance_Goal"]
	$Sprite/TextureProgressItem.value = my_info["Distance_Special_Item"]
	if my_info["Type"] == "Local":
		if my_info["Distance_Goal"] > my_info["Distance_Special_Item"]:
			$Sprite/TextureProgressGoal/Anim.play("signal")
		elif my_info["Distance_Goal"] < my_info["Distance_Special_Item"]:
			$Sprite/TextureProgressItem/Anim.play("signal")
		else:
			$Sprite/TextureProgressGoal/Anim.play("signal")
			$Sprite/TextureProgressItem/Anim.play("signal")
	pass # func _ready


# SETa TODAS as informações/atributos da Carta
# Chamando todas as funções individuais pra cada atributo
func set_card_atributes(value : Dictionary) -> void:
	clean_info_card()
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
	get_parent().scale = Vector2(1.2,1.2)
	get_parent().self_modulate = my_info["Moldure_Color"]
	
	pass # func _on_CardBase_mouse_entered


# Referencia a Carta que esta sendo "DES"FOCADA
func _on_CardBase_mouse_exited() -> void:
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