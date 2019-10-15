extends Area2D

var pre_focus : Dictionary
var pos_focus : Dictionary

var actual_body : Dictionary

var clicking : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	
	position = get_global_mouse_position()
	
	pass


func _on_Mouse_body_entered(body: PhysicsBody2D) -> void:
	pre_focus = body.get_info_card()
	print(pre_focus)
	pass # Replace with function body.


func _on_Mouse_body_exited(body: PhysicsBody2D) -> void:
	pre_focus = {}
	print(pre_focus)
	pass # Replace with function body.


func _unhandled_input(event: InputEvent) -> void:
	if event == InputEventMouseButton and event.is_action_pressed("click"):
#		pre_focus =
		pass