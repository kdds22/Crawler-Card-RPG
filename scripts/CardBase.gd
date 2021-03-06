extends RigidBody2D


# =====================================================
# Propriedade das Cartas
# =====================================================
var my_info : Dictionary = {}



#var card_type : String = ""
#var card_name : String = ""
#var card_image : String = ""
#var card_description : String = "Card Info"
#var card_power : int = 0
#var card_distance_goal : int = 0
#var card_distance_special_item : int = 0
#var card_has_item : bool = false
#
#var my_moldure_color : Color
#var my_index_table = 0
#
#var my_group : String
# =====================================================
# Fim da Propriedade das Cartas
# =====================================================

var initial_position : Vector2

var focused := false # usado pra indicar uma carta
var clicked := false # usado como um FLAG de clique unico
var moving := false 
var handling := false


# PEGA todas as informações da Carta
# Retorna um dicionario de atributos
func get_info_card() -> Dictionary:
#	var info : Dictionary
#	info["Type"] = card_type
#	info["Name"] = card_name
#	info["Image"] = card_image
#	info["Description"] = card_description
#	info["Power"] = card_power
#	info["Distance_Goal"] = card_distance_goal
#	info["Distance_Special_Item"] = card_distance_special_item
#	info["Has_Item"] = card_has_item
#	info["Moldure_Color"] = my_moldure_color
#	info["Index"] = my_index_table
#	info["Group"] = my_group
	
#	return info  # func get_info_card
	return my_info  # func get_info_card


# SETar todos os atributos para a nova carta
# Dicionario -> Local_Variaveis
func set_info_card(card : Dictionary) -> void:
	my_info = card
#	card_type = card["Type"]
#	card_name = card["Name"]
#	card_image = card["Image"]
#	card_description = card["Description"]
#	card_power = card["Power"]
#	card_distance_goal = card["Distance_Goal"]
#	card_distance_special_item = card["Distance_Special_Item"]
#	card_has_item = card["Has_Item"]
#	my_moldure_color = card["Moldure_Color"]
#	my_index_table = card["Index"]
#	my_group = card["Group"]
#	set_card_atributes(get_info_card())
	set_card_atributes(my_info)
	
	pass # func set_info_card


# LIMPA todos os atributos da carta
func clean_info_card() -> void:
	my_info = {}
#	card_type = ""
#	card_name = ""
#	card_image = ""
#	card_description = "Card Info"
#	card_power = 0
#	card_distance_goal = 0
#	card_distance_special_item = 0
#	card_has_item = false
#	my_moldure_color = Color.black
#	my_index_table = 0
#	my_group = ""
	
	pass # func clean_info_card


# Função pra Executar qualquer ação de "entrada" sobre a carta
# Normalmente ações com o Mouse
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if focused and event is InputEventMouseButton:
#			print("______________ Input CARD _______________")
#			print("Tipo: " + card_type + " - Nome: " + card_name + " - Grupos: " , self.get_groups())
			if not clicked:
#				if card_type == "Local":
				if my_info["Type"] == "Local":
					get_node("../../..").card_clicked(self) # MainCore.gd
					clicked = true
#				if card_type == "Action":
				if my_info["Type"] == "Action":
#					print("Carta de AÇÃO -> ",card_name)
					print("Carta de AÇÃO -> ",my_info["Name"])
#					if card_description == "Potion":
					if my_info["Description"] == "Potion":
						clicked = true
						z_index = 1
#				if card_type == "Weapon":
				if my_info["Type"] == "Weapon":
					clicked = true
					z_index = 1
	if event.is_action_released("click"):
		if focused:
			if clicked:
				print("Clicked...")
#				if card_type == "Weapon":
				if my_info["Type"] == "Weapon":
					CardManager.card_clicked = self
			elif not clicked:
				print("Not Clicked...")
#				if card_type == "Action" and card_description == "Enemy" and CardManager.card_clicked != null:
				if my_info["Type"] == "Action" and my_info["Description"] == "Enemy" and CardManager.card_clicked != null:
					CardManager.card_released = self
			
			CardManager.make_interaction()
		
		position = initial_position
		clicked = false
		focused = false
		z_index = 0
	if clicked and event is InputEventMouseMotion:
#		if card_type == "Weapon":
		if my_info["Type"] == "Weapon":
			moving = true
#			global_position = get_node("/root/MainCore/Mouse").global_position
			global_position = get_global_mouse_position()
#		if card_type == "Action" and card_description == "Potion":
		if my_info["Type"] == "Action" and my_info["Description"] == "Potion":
			moving = true
			global_position = get_global_mouse_position()
#			print(event)
		moving = false
	
	pass # func _input


# Chamado ao Instanciar uma Carta
func _ready() -> void:
	print(position, name)
#	$Sprite/TextureProgressGoal.value = card_distance_goal
#	$Sprite/TextureProgressItem.value = card_distance_special_item
	$Sprite/TextureProgressGoal.value = my_info["Distance_Goal"]
	$Sprite/TextureProgressItem.value = my_info["Distance_Special_Item"]
	pickable(false)
#	for i in self.get_groups():
#		if i != 'root_canvas131' and i != '_vp_input1118':
##			print(card_name, " Pertence ao Grupo -> "+i)
#			pass
#	if card_type == "Local":
	if my_info["Type"] == "Local":
#		print(card_distance_goal, " e ", card_distance_special_item)
		print(my_info["Distance_Goal"], " e ", my_info["Distance_Special_Item"])
#		if card_distance_goal > card_distance_special_item:
		if my_info["Distance_Goal"] > my_info["Distance_Special_Item"]:
			$Sprite/TextureProgressGoal/Anim.play("signal")
#		elif card_distance_goal < card_distance_special_item:
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
#	card_distance_goal = value
	my_info["Distance_Goal"] = value
func get_card_distance_goal() -> int:
#	return card_distance_goal
	return my_info["Distance_Goal"]
###################################################
func set_card_distance_special_item(value : int) -> void:
#	card_distance_special_item = value
	my_info["Distance_Special_Item"] = value
func get_card_distance_special_item() -> int:
#	return card_distance_special_item
	return my_info["Distance_Special_Item"]
# func SET-GET card_distance - goal/special_item


#SETa o INDEX (do "parent") correspondente na MESA
func set_card_index(value : int):
#	my_index_table = value
	my_info["Index"] = value
	
	pass # func set_card_index


#SETa um grupo a Carta
func set_card_group(value : String) -> void:
	if not value == null:
		add_to_group(value)
#		my_group = value
		my_info["Group"] = value
	pass # func set_card_group


#SET-GET do TIPO da Carta
func set_name_type(value : String) -> void:
#	card_type = value
	my_info["Type"] = value
	$Sprite/NameType.text = value
	set_cristais(value)
func get_name_type() -> String:
	return $Sprite/NameType.text


#SETagem da IMAGEM da Carta
func set_image_type(value) -> void:
#	card_image = value
	my_info["Image"] = value
	if value != "Null":
		$Sprite/ImageType.texture = load(value)
	else: print(value + " CardBase_set_image_type")

	pass # func set_image_type


#SETagem do NOME da Carta
func set_name_desc(value : String) -> void:
#	card_name = value
	my_info["Name"] = value
	$Sprite/NameDesc.text = value
	
	pass # func set_name_desc


#SETagem da DESCRICAO da Carta
func set_description(value : String) -> void:
#	card_description = value
	my_info["Description"] = value
	
	pass # func set_description


#SETagem dos CRISTAIS da Carta
func set_cristais(value : String) -> void:
	match value:
		"Action":
			cristal_rect(Rect2(16,0,16,16), Rect2(16,16,16,16)) # vermelho
#			my_moldure_color = Color(1.5,.05,.05,255)
			my_info["Moldure_Color"] = Color(1.5,.05,.05,255)
		"Weapon":
			cristal_rect(Rect2(32,0,16,16), Rect2(32,16,16,16)) # verde
#			my_moldure_color = Color(.05,1.5,.05,1)
			my_info["Moldure_Color"] = Color(.05,1.5,.05,1)
		"Local":
			cristal_rect(Rect2(0,0,16,16), Rect2(0,16,16,16)) # azul
#			my_moldure_color = Color(.05,.05,1.5,1)
			my_info["Moldure_Color"] = Color(.05,.05,1.5,1)
		"Player":
			cristal_rect(Rect2(48,0,16,16), Rect2(48,16,16,16)) # amarelo
#			my_moldure_color = Color(1.5,1.5,.05,1)
			my_info["Moldure_Color"] = Color(1.5,1.5,.05,1)

	pass # func set_cristais


#Define a REGION da SPRITE dos cristais/joias -> CardBase
func cristal_rect(rect2_mini : Rect2, rect2_big : Rect2) -> void:
	$Sprite/CristalMini.region_rect = rect2_mini
	$Sprite/CristalBig.region_rect = rect2_big

	pass # func cristal_rect



# Referencia a Carta que esta sendo FOCADA
func _on_CardBase_mouse_entered() -> void:
	focused = true
	get_parent().scale = Vector2(1.2,1.2)
#	get_parent().self_modulate = my_moldure_color
	get_parent().self_modulate = my_info["Moldure_Color"]
	
	pass # Replace with function body.


# Referencia a Carta que esta sendo "DES"FOCADA
func _on_CardBase_mouse_exited() -> void:
	focused = false
	clicked = false
	get_parent().scale = Vector2(1.1,1.1)
	get_parent().self_modulate = Color(1,1,1)
	
	pass # Replace with function body.


# Ativa uma ANIMAÇÂO de IN-OUT na carta, prestes a ser excluida do jogo
func call_anim_out() -> void:
	if focused:
		$Anim.play("out")
	else:
		$Anim.play("out_2")
	
	pass # func call_anim_out


func call_anim_hit() -> void:
	$Anim.play("hit")
	
	pass


# Altera a possibilidade de poder clicar na carta
func pickable(value : bool) -> void:
	input_pickable = value
	
	pass # func pickable