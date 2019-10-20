extends Area2D

var pre_focus : Dictionary = {}
var pos_focus : Dictionary = {}

var actual_body : Dictionary = {}

var clicking : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	
	position = get_global_mouse_position()
	
	pass


func _on_Mouse_body_entered(body: PhysicsBody2D) -> void:
#	body.focused = true
	if body.has_method("get_info_card"):
		pre_focus = body.get_info_card()
	print()
	print("==========================================")
	print("----- Mouse Entrada -----")
	print(pre_focus, "Focado")
	print("----- Mouse Entrada -----")
	print("==========================================")
	print()
#	print(pre_focus) # Imprimir os atributos da carta
	pass # Replace with function body.


func _on_Mouse_body_exited(body: PhysicsBody2D) -> void:
#	body.focused = false
	print(pre_focus)
	pre_focus.clear()
	print(pre_focus)
	"""
	if pre_focus != {}:
		print()
		print("==========================================")
		print("----- Mouse Saida -----")
		print(pre_focus["Name"], "DesFocado")
		print("----- Mouse Saida -----")
		print("==========================================")
		print()
	"""
#	pre_focus = {}
#	print(pre_focus) # imprimir os atributos da carta, resultado = null / {}
	pass # Replace with function body.


"""
func _unhandled_input(event: InputEvent) -> void:
	if event == InputEventMouseButton:
		if event.is_action_pressed("click"):
			if pre_focus != {}:
				actual_body = pre_focus
		if event.is_action_released("click"):
			if pre_focus == {}:
				actual_body = {}
				CardManager.clear_maked()
		pass
"""