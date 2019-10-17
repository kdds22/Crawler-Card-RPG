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
	pre_focus = body.get_info_card()
	body.focused = true
#	print(pre_focus) # Imprimir os atributos da carta
	pass # Replace with function body.


func _on_Mouse_body_exited(body: PhysicsBody2D) -> void:
	pre_focus = {}
	body.focused = false
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