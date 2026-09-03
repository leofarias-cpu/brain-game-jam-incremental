class_name Bullet extends CharacterBody2D

@export var stats: BulletStats
var direction: int = 1

signal hit(bullet: Bullet)

var disabled := true
var go_crazy := false

func _physics_process(delta: float) -> void:
	if disabled: return
	
	var speed : float = stats.speed * (1.5 if go_crazy else 1.0)
	var collision := move_and_collide(Vector2(speed, 0) * direction * delta)
	
	if collision:
		hit.emit(self)

func get_graze_value() -> int:
	return stats.graze * stats.graze_mult
