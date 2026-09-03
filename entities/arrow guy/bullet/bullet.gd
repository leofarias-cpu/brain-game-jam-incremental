class_name Bullet extends CharacterBody2D

@export var stats: BulletStats
var direction: int = 1:
	set(v):
		direction = v
		if v == 1:
			rotation_degrees = 0
		elif v == -1:
			rotation_degrees = 180

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


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Hurtbox": # Maior gambiarra da minha vida
		hit.emit(self)
