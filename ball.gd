extends CharacterBody2D

@export var speed: float = 400
@export var vertical_velocity: float = 400


signal touched_wall(wall_name)

enum BallDirection {
	LEFT,
	RIGHT
}
var direction: BallDirection = BallDirection.RIGHT

func _ready() -> void:
	velocity = Vector2(speed * 1, speed)
	DebugOverlay.add_property(self, "velocity", DebugOverlay.DISPLAY_TYPE.ROUND)

func _physics_process(delta: float) -> void:
	var collide = move_and_collide(velocity * delta)
	if (collide):
		velocity = velocity.bounce(collide.get_normal())
		var collider: StaticBody2D = collide.get_collider()
				
		if(collider.is_in_group("left")):
			touched_wall.emit("left")
		elif(collider.is_in_group("right")):
			touched_wall.emit("right")
	
	if (velocity.x > 0 && velocity.x < 100):
		velocity.x = 200
