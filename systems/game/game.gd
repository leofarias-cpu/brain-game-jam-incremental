extends Node2D

@export var hp = 3:
	set(value):
		hp = value
		if hp <= 0:
			get_tree().paused = true
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(3).timeout
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_hit() -> void:
	hp -= 1
