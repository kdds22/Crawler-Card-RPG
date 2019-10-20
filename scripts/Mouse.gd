extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	
	position = get_global_mouse_position()
	
	pass


func _on_Mouse_body_entered(body: PhysicsBody2D) -> void:
	CardManager._on_card_interacting = body
	print("\nMouse: ",body.my_info["Name"], "\n")
	pass # Replace with function body.


func _on_Mouse_body_exited(body: PhysicsBody2D) -> void:
	body.position = body.initial_position
	pass # Replace with function body.
