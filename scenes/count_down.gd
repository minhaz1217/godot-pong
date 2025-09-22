extends Control

signal timer_finished

@export var time: int = 3

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

var current_time = 0

func _ready() -> void:
	current_time = time
	timer.start(1)
	label.set_text(str(current_time))
	
func _on_timer_timeout() -> void:
	current_time -= 1
	label.set_text(str(current_time))
	if(current_time > 0):
		print(current_time)
		timer.start(1)
	else:
		timer_finished.emit()
		queue_free()
