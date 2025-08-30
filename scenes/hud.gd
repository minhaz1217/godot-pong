extends CanvasLayer
@export var hide_after_game_starts: Array[Node]
@onready var score_label: Label = $score


func _ready() -> void:
	GlobalScript.game_state.connect(manage_game_state)
	GlobalScript.update_score.connect(manage_update_score)

func start_game():
	for element in hide_after_game_starts:
		element.visible = false

func game_over():
	for element in hide_after_game_starts:
		element.visible = true

func _on_button_pressed() -> void:
	GlobalScript.game_state.emit(GlobalScript.GameState.START)


func manage_game_state(state: GlobalScript.GameState):
	if(state == GlobalScript.GameState.START):
		start_game()
	elif(state == GlobalScript.GameState.GAME_OVER):
		game_over()

func manage_update_score(score: String):
	score_label.text = score
