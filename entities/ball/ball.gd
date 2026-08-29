class_name Ball extends CharacterBody2D

var facing_direction: Vector2
var speed_current: float
@export var stats: BallStats
@export var hitbox: Grazeable
@export var physics_collision: CollisionShape2D
@export var hitbox_collision: CollisionShape2D


func _draw() -> void:
	draw_circle(Vector2.ZERO, stats.radius, stats.color, true, -1, true)


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	facing_direction = Vector2.from_angle(deg_to_rad(randf_range(0, 360))).normalized()
	
	speed_current = stats.speed
	hitbox.graze = stats.graze * stats.graze_mult
	
	physics_collision.shape.radius = stats.radius * 0.9 # If its the same size the ball just bounce off the player
	hitbox_collision.shape.radius = stats.radius


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(speed_current * facing_direction * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		# + random to avoid a ball bouncing perfectly in a straight line
		facing_direction = (facing_direction.bounce(collision.get_normal())  + Vector2.ONE * randf_range(-0.5, 0.5)).normalized()
		move_and_collide(reflect)

func go_crazy():
	var tween = get_tree().create_tween().set_parallel()
	tween.tween_property(self, "speed_current", stats.speed * 1.5, 0.5)
	tween.tween_property(self, "modulate", Color.FIREBRICK, 0.5)
