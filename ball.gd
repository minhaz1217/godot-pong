extends CharacterBody2D

@export var speed: float = 400
@export var vertical_velocity: float = 400
enum BallDirection{
	LEFT,
	RIGHT
}
var direction : BallDirection = BallDirection.RIGHT

func _ready() -> void:
	velocity = Vector2(speed * 1, speed)
	DebugOverlay.add_property(self, "velocity", DebugOverlay.DISPLAY_TYPE.ROUND)

func _physics_process(delta: float) -> void:
	var collide = move_and_collide(velocity * delta)
	if(collide):
		velocity = velocity.bounce(collide.get_normal())
		#print("Angle: ", collide.get_angle())
		#print("Normal: ", collide.get_collider().get_class().get_basename(), collide.get_collider_rid())
	#vertical_velocity = randf_range(100, 200)
	#if(direction == BallDirection.RIGHT):
		#position.x += speed * delta
	#elif(direction == BallDirection.LEFT):
		#position.x -= speed * delta
	#
	#position.y += vertical_velocity * delta
