extends Sprite2D

@export var bullet_spawn_point: Marker2D
@export var arrow_guy: Shooter_inner
var direction := 1

signal in_position

func _process(delta: float) -> void:
	await get_tree().create_timer(0.1).timeout
	var target = Vector2(position.x, arrow_guy.position.y)
	
	position = position.move_toward(target, (arrow_guy.stats.speed - 2) * delta)
	if position.y == arrow_guy.position.y:
		in_position.emit()



func reset():
	if direction == 1:
		position.x = 13
		rotation_degrees = 37
		flip_h = false
		bullet_spawn_point.position.x = 18
	else:
		position.x = -13
		rotation_degrees = -37
		flip_h = true
		bullet_spawn_point.position.x = -18
		
		
