extends RigidBody2D





func _ready() -> void:
	
	pass # func _ready


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


#SETagem dos CRISTAIS da Carta
func set_cristais(value : String) -> void:
	match value:
		"AÇÃO":
			cristal_rect(Rect2(16,0,16,16), Rect2(16,16,16,16))
			
			pass
			
		"ARMA":
			cristal_rect(Rect2(32,0,16,16), Rect2(32,16,16,16))
			
			pass
			
		"LOCAL":
			cristal_rect(Rect2(0,0,16,16), Rect2(0,16,16,16))
			
			pass
			
		"PLAYER":
			cristal_rect(Rect2(48,0,16,16), Rect2(48,16,16,16))
			
			pass
	
	pass # func set_cristais


#Define a REGION da SPRITE dos cristais/joias -> CardBase
func cristal_rect(rect2_mini : Rect2, rect2_big : Rect2):
	$Sprite/CristalMini.region_rect = rect2_mini
	$Sprite/CristalBig.region_rect = rect2_big
	
	pass # func cristal_rect










