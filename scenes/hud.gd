extends CanvasLayer
@export var hide_after_game_starts: Array[Node]

func start_game():
	for element in hide_after_game_starts:
		element.visible = false


func _on_button_pressed() -> void:
	start_game()
	GlobalScript.game_state.emit(GlobalScript.GameState.START)
