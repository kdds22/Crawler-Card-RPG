extends Node2D

signal timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func end_time():
	emit_signal("timeout")

func call_anim(value):
	match value:
		"run":
			$ClockAnim.play("run_time")
		"turn":
			$ClockAnim.play("turn_time")
	pass