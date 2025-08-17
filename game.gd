extends Node2D

@onready var player_1: Sprite2D = $Player1
@onready var player_2: Sprite2D = $Player2


func _enter_tree() -> void:
	DebugOverlay.setup_debugger($DebugOverlay)

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass
