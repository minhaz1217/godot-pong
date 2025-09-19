extends Sprite2D

enum Player {
	player_1,
	player_2
}
@export var player_type : Player
var velocity: float = 400
var screen_width = 250
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	DebugOverlay.add_property(self, "position", DebugOverlay.DISPLAY_TYPE.ROUND)

func _process(delta: float) -> void:
	if(player_type == Player.player_1):
		process_player1_input(delta)
	else:
		process_player2_input(delta)


func process_player1_input(delta: float):
	if(not GlobalScript.game_running): return
	var next_pos = 0
	if Input.is_action_pressed("player1_up"):
		next_pos = position.y - velocity * delta
	elif Input.is_action_pressed("player1_down"):
		next_pos = position.y + velocity * delta
		
	if(not is_at_screen_boundary(next_pos) and next_pos != 0):
		position.y = next_pos

func is_at_screen_boundary(next_pos:float) -> bool:
	if(next_pos >= screen_width * -1 && next_pos <= screen_width):
		return false
	return true

func process_player2_input(delta: float):
	if(not GlobalScript.game_running): return
	var next_pos = 0
	if Input.is_action_pressed("player2_up"):
		next_pos = position.y - velocity * delta
	elif Input.is_action_pressed("player2_down"):
		next_pos = position.y + velocity * delta
		
	if(not is_at_screen_boundary(next_pos) and next_pos != 0):
		position.y = next_pos
		
		
func bounce() -> void:
	animation_player.play("hit")
