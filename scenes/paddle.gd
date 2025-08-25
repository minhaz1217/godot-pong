extends Sprite2D

enum Player {
	player_1,
	player_2
}
@export var player_type : Player
var velocity: float = 400

func _process(delta: float) -> void:
	
	if(player_type == Player.player_1):
		process_player1_input(delta)
	else:
		process_player2_input(delta)


func process_player1_input(delta: float):
	if Input.is_action_pressed("player1_up"):
		position.y -= velocity * delta
	elif Input.is_action_pressed("player1_down"):
		position.y += velocity * delta


func process_player2_input(delta: float):
	if Input.is_action_pressed("player2_up"):
		position.y -= velocity * delta
	elif Input.is_action_pressed("player2_down"):
		position.y += velocity * delta
		
