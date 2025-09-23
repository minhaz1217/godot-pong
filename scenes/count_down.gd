extends Control

signal timer_finished

@export var time: int = 3

@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@onready var count_down_sound: AudioStreamPlayer2D = $CountDownSound
@onready var count_down_end: AudioStreamPlayer2D = $CountDownEnd

var current_time = 0

func _ready() -> void:
	current_time = time
	timer.start(1)
	label.set_text(str(current_time))
	count_down_sound.play()
	
func _on_timer_timeout() -> void:
	current_time -= 1
	label.set_text(str(current_time))
	if(current_time > 0):
		count_down_sound.play()
		timer.start(1)
	else:
		count_down_end.play()
		count_down_end.connect("finished", queue_free)
		timer_finished.emit()
