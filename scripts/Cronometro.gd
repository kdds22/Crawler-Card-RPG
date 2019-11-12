extends Node2D

signal timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


# Emite um sinal informando que o tempo acabou
func end_time():
	emit_signal("timeout")
	call_anim("turn")
	
	pass # func end_time


# Seta qual será a animação do cronometro
func call_anim(value):
	match value:
		"run":
			$ClockAnim.play("run_time")
		"turn":
			$ClockAnim.play("turn_time")
			restart_clock()
	
	pass # func call_anim


# Reinicia o tempo do Cronometro apos 3 segundos
func restart_clock():
	yield(get_tree().create_timer(3),"timeout")
	call_anim("run")
	
	pass # func restart_clock