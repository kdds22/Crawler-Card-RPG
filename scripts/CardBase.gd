extends RigidBody2D


# =====================================================
# Propriedade das Cartas
# =====================================================
var card_type : String = ""
var card_name : String = ""
var card_image : String = ""
var card_description : String = "Card Info"
var card_power : int = 0
var card_distance_goal : int = 0
var card_distance_special_item : int = 0
var card_has_item : bool = false

var my_moldure_color : Color
var my_index_table = 0
# =====================================================
# Fim da Propriedade das Cartas
# =====================================================




var focused = false


func get_info_card() -> Dictionary:
	var info : Dictionary
	info["Type"] = card_type
	info["Name"] = card_name
	info["Image"] = card_image
	info["Description"] = card_description
	info["Power"] = card_power
	info["Distance_Goal"] = card_distance_goal
	info["Distance_Special_Item"] = card_distance_special_item
	info["Has_Item"] = card_has_item
	info["Moldure_Color"] = my_moldure_color
	info["Index"] = my_index_table
	return info


func set_info_card(card : Dictionary) -> void:
	card_type = card["Type"]
	card_name = card["Name"]
	card_image = card["Image"]
	card_description = card["Description"]
	card_power = card["Power"]
	card_distance_goal = card["Distance_Goal"]
	card_distance_special_item = card["Distance_Special_Item"]
	card_has_item = card["Has_Item"]
	my_moldure_color = card["Moldure_Color"]
	my_index_table = card["Index"]


func clean_info_card():
	card_type = ""
	card_name = ""
	card_image = ""
	card_description = "Card Info"
	card_power = 0
	card_distance_goal = 0
	card_distance_special_item = 0
	card_has_item = false

func _input(event):
	if event.is_action_pressed("click"):
		if focused and event is InputEventMouseButton:
			print("Tipo: " + card_type + " - Nome: " + card_name)
			if card_type == "Local":
#				CardManager.local_card_clicked(card_name)
				get_node("../../..").card_clicked(self) # MainCore.gd
#			print(event)
	pass


func _ready() -> void:

	print(get_parent().name+" - ",my_index_table)
	for i in self.get_groups():
		if i != 'root_canvas131' and i != '_vp_input1118':
			print("Grupo da Carta -> "+i)
	pass # func _ready


func set_card_atributes(value : Dictionary):
	clean_info_card()
	print("Value Cards -> ", value)
	set_name_type(value["Type"])
	set_image_type(value["Image"])
	set_name_desc(value["Name"])
	pass


#SET-GET do NOME da Carta
func set_name_type(value : String):
	card_type = value
	$Sprite/NameType.text = value
	set_cristais(value)
func get_name_type():
	return $Sprite/NameType.text


#SETagem da IMAGEM da Carta
func set_image_type(value) -> void:
	card_image = value
	if value != "Null":
		$Sprite/ImageType.texture = load(value)
	else: print(value + " CardBase_set_image_type")

	pass # func set_image_type


#SETagem da DESCRICAO da Carta
func set_name_desc(value : String):
	card_name = value
	$Sprite/NameDesc.text = value
	pass # func set_name_desc


#SETagem dos CRISTAIS da Carta
func set_cristais(value : String) -> void:
	match value:
		"Action":
			cristal_rect(Rect2(16,0,16,16), Rect2(16,16,16,16)) # vermelho
			my_moldure_color = Color(1.5,.05,.05,255)
		"Weapon":
			cristal_rect(Rect2(32,0,16,16), Rect2(32,16,16,16)) # verde
			my_moldure_color = Color(.05,1.5,.05,1)
		"Local":
			cristal_rect(Rect2(0,0,16,16), Rect2(0,16,16,16)) # azul
			my_moldure_color = Color(.05,.05,1.5,1)
		"Player":
			cristal_rect(Rect2(48,0,16,16), Rect2(48,16,16,16)) # amarelo
			my_moldure_color = Color(1.5,1.5,.05,1)

	pass # func set_cristais


#Define a REGION da SPRITE dos cristais/joias -> CardBase
func cristal_rect(rect2_mini : Rect2, rect2_big : Rect2) -> void:
	$Sprite/CristalMini.region_rect = rect2_mini
	$Sprite/CristalBig.region_rect = rect2_big

	pass # func cristal_rect



# Referencia a Carta que esta sendo FOCADA
func _on_CardBase_mouse_entered() -> void:
	focused = true
#	print(focused)
	get_parent().scale = Vector2(1.1,1.1)
	get_parent().self_modulate = my_moldure_color
	pass # Replace with function body.


# Referencia a Carta que esta sendo "DES"FOCADA
func _on_CardBase_mouse_exited() -> void:
	focused = false
#	print(focused)
	get_parent().scale = Vector2(1,1)
	get_parent().self_modulate = Color(1,1,1)
	pass # Replace with function body.
