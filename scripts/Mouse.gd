extends Area2D



func _process(delta: float) -> void:
	if CoreSystemManager.process:
		position = get_global_mouse_position()
	
	pass


# Detecção do Body com Mouse_Area (ENTRADA)
func _on_Mouse_body_entered(body: PhysicsBody2D) -> void:
	CardManager._on_card_interacting = body
	print("\nMouse Entrou: ",body.my_info["Name"], "\n")
	pass # func _on_Mouse_body_entered


# Detecção do Body com Mouse_Area (ENTRADA)
func _on_Mouse_body_exited(body: PhysicsBody2D) -> void:
	CardManager._on_card_interacting = null
	body.position = body.initial_position
	print("\nMouse Saiu: ",body.my_info["Name"], "\n")
	pass # func _on_Mouse_body_exited
