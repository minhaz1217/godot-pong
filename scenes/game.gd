extends Node2D

@onready var player_1: Sprite2D = $Player1
@onready var player_2: Sprite2D = $Player2
@onready var score: Label = $CanvasLayer/score
@onready var ball: CharacterBody2D = $ball

var player1_score: int = 0
var player2_score: int = 0
var ball_starting_position
func _enter_tree() -> void:
	DebugOverlay.setup_debugger($DebugOverlay)
	

func _ready() -> void:
	ball_starting_position = ball.position
	ball.velocity.y = randi_range(50, 200)
	
func reset_game():
	ball.position = ball_starting_position
	
func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_ball_touched_wall(wall_name: Variant) -> void:
	if (wall_name == "left"):
		player2_score += 1
		print("LEFT")
	elif (wall_name == "right"):
		player1_score += 1
		print("RIGHT")
	update_score()
	reset_game()
	

func update_score() -> void:
	score.text = str(player1_score) + " : " + str(player2_score)
