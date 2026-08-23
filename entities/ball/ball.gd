extends CharacterBody2D

var facing_direction: Vector2
var speed_current: float
@export var base_stats: BallStats
@export var hitbox: Grazeable

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	facing_direction = Vector2.from_angle(deg_to_rad(randf_range(0, 360))).normalized()
	speed_current = base_stats.speed
	hitbox.graze = base_stats.graze

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(speed_current * facing_direction * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		# + random to avoid a ball bouncing perfectly in a straight line
		facing_direction = (facing_direction.bounce(collision.get_normal())  + Vector2.ONE * randf_range(-0.5, 0.5)).normalized()
		move_and_collide(reflect)
