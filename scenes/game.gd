extends Node2D

@onready var player_1: Sprite2D = $Player1
@onready var player_2: Sprite2D = $Player2
@onready var score: Label = $CanvasLayer/score
@onready var ball: CharacterBody2D = $ball
@onready var camera: Camera2D = $camera
@onready var debug_overlay: MarginContainer = $DebugOverlay
@onready var backgrounds = [$backgrounds/background1, $backgrounds/background2]
@onready var game: Node2D = $"."

var player1_score: int = 0
var player2_score: int = 0
var winning_score: int = 5 # if score reaches this point, it's game over
var ball_starting_position


const count_down_scene = preload("res://scenes/count_down.tscn")


func _enter_tree() -> void:
	DebugOverlay.setup_debugger($DebugOverlay)
	

func _ready() -> void:
	if(not GlobalScript.enable_debug):
		debug_overlay.visible = false
		
	ball_starting_position = ball.position
	ball.velocity.y = randi_range(50, 200)
	GlobalScript.main_camera = camera
	GlobalScript.game_state.connect(manage_game_state)
	pick_a_background()

func pick_a_background():
	for background in backgrounds:
		background.visible = false
	backgrounds.pick_random().visible = true
	
func reset_game():
	ball.position = ball_starting_position
	
	ball.velocity.y = randf_range(200, 400) * [1,-1].pick_random()
	if(player1_score >= winning_score || player2_score >= winning_score):
		GlobalScript.game_state.emit(GlobalScript.GameState.GAME_OVER)
	

func _process(_delta: float) -> void:
	handle_input()

func handle_input():
	if Input.is_action_just_pressed("start_game"):
		if(not GlobalScript.game_running):
			GlobalScript.game_state.emit(GlobalScript.GameState.START)
			
func _on_ball_touched_wall(wall_name: Variant) -> void:
	if (wall_name == "left"):
		player2_score += 1
		GlobalScript.main_camera.shake(.3, 200, 60)
		start_count_down()
	elif (wall_name == "right"):
		player1_score += 1
		GlobalScript.main_camera.shake(.3, 200, 60)
		start_count_down()
	update_score()
	reset_game()
	
func start_count_down() -> void :
	GlobalScript.game_running = false
	var count_down = count_down_scene.instantiate()
	count_down.connect("timer_finished", finished_count_down)
	game.add_child(count_down)

func finished_count_down() -> void:
	GlobalScript.game_running = true


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
	pick_a_background()
	GlobalScript.game_running = true

func manage_game_state(state: GlobalScript.GameState):
	if(state == GlobalScript.GameState.START):
		start_game()
	elif(state == GlobalScript.GameState.GAME_OVER):
		game_over()
