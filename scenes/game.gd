extends Node2D

@onready var player_1: Sprite2D = $Player1
@onready var player_2: Sprite2D = $Player2
@onready var score: Label = $CanvasLayer/score
@onready var ball: CharacterBody2D = $ball
@onready var camera: Camera2D = $camera

var player1_score: int = 0
var player2_score: int = 0
var winning_score: int = 5 # if score reaches this point, it's game over
var ball_starting_position


func _enter_tree() -> void:
	DebugOverlay.setup_debugger($DebugOverlay)
	

func _ready() -> void:
	ball_starting_position = ball.position
	ball.velocity.y = randi_range(50, 200)
	GlobalScript.main_camera = camera
	GlobalScript.game_state.connect(manage_game_state)
	
func reset_game():
	ball.position = ball_starting_position
	if(player1_score >= winning_score || player2_score >= winning_score):
		GlobalScript.game_state.emit(GlobalScript.GameState.GAME_OVER)
	
func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_ball_touched_wall(wall_name: Variant) -> void:
	if (wall_name == "left"):
		player2_score += 1
		GlobalScript.main_camera.shake(.3, 200, 60)
	elif (wall_name == "right"):
		player1_score += 1
		GlobalScript.main_camera.shake(.3, 200, 60)
	update_score()
	reset_game()
	

func update_score() -> void:
	var score_text = str(player1_score) + " : " + str(player2_score)
	GlobalScript.update_score.emit(score_text)

func game_over():
	GlobalScript.game_running = false
	
func start_game():
	player1_score = 0
	player2_score = 0
	update_score()
	reset_game()
	GlobalScript.game_running = true

func manage_game_state(state: GlobalScript.GameState):
	if(state == GlobalScript.GameState.START):
		start_game()
	elif(state == GlobalScript.GameState.GAME_OVER):
		game_over()
