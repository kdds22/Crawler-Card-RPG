extends RigidBody2D





func _ready() -> void:
	
	pass # func _ready


#SET-GET do NOME da Carta
func set_name_type(value : String):
	$Sprite/NameType.text = value
func get_name_type():
	return $Sprite/NameType.text


#SETagem da IMAGEM da Carta
func set_image_type(value : String):
	if value != null:
		$Sprite/ImageType.texture = load(value)














