extends RigidBody2D


# =====================================================
# Propriedade das Cartas
# =====================================================
var card_type : String
var card_name : String
var card_image : String
var card_description : String
var card_power : int
var card_distance_goal : int
var card_distance_special_item : int
var card_has_item : bool
# =====================================================
# Fim da Propriedade das Cartas
# =====================================================



var my_moldure_color : Color

var my_index_table = 0

var focused = false


func _ready() -> void:

	print(get_parent().name+" - ",my_index_table)
	for i in self.get_groups():
		if i != 'root_canvas131':
			print("Grupo da Carta -> "+i)
	pass # func _ready


func set_card_atributes(value : Dictionary):
	set_name_type(value["Type"])
	set_image_type(value["Image"])
	set_name_desc(value["Name"])
	pass


#SET-GET do NOME da Carta
func set_name_type(value : String):
	$Sprite/NameType.text = value
	set_cristais(value)
func get_name_type():
	return $Sprite/NameType.text


#SETagem da IMAGEM da Carta
func set_image_type(value) -> void:
	if value != "Null":
		$Sprite/ImageType.texture = load(value)
	else: print(value + " CardBase_set_image_type")

	pass # func set_image_type


#SETagem da DESCRICAO da Carta
func set_name_desc(value : String):
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
