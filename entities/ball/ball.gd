extends CharacterBody2D

var facing_direction: Vector2
@export var speed: float


func _ready() -> void:
	facing_direction = Vector2.from_angle(deg_to_rad(randf_range(0, 360))).normalized()
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(speed * facing_direction * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		# + random to avoid a ball bouncing perfectly in a straight line
		facing_direction = (facing_direction.bounce(collision.get_normal())  + Vector2.ONE * randf_range(-0.5, 0.5)).normalized()
		move_and_collide(reflect)
