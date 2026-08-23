extends Node2D

@export var hp = 3:
	set(value):
		hp = value
		if hp <= 0:
			get_tree().paused = true

@export var play_space_height: float
@export var play_space_width: float
@export var play_space_border_width: float
@export var play_space: PlaySpace

@export var enemies: Array[PackedScene]

func _ready() -> void:
	play_space.height = play_space_height
	play_space.width = play_space_width
	play_space.border_width = play_space_border_width
	play_space.update_size()
	
	round_start()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		play_space.height += 32
		play_space.width += 32
		play_space.update_size()
	const directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	#for i in 20:
		#await get_tree().create_timer(1).timeout
		#var direction: Vector2 = directions.pick_random()
		#print("Side: %s = %s" % [direction, play_space.get_point_from_side(direction, 0.5)])


func _on_player_hit() -> void:
	hp -= 1

func round_start():
	for i in enemies.size():
		var scene = enemies[i]
		var new_enemy = scene.instantiate()
		
		if new_enemy is Node2D:
			const directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
			const colors = [Color.RED, Color.BLUE, Color.GREEN, Color.WHITE]
			
			var direction: Vector2 = directions[i % 4]
			
			new_enemy.position = play_space.get_point_from_side(direction, 0.4)
			new_enemy.rotation = direction.angle()
			new_enemy.modulate = colors[i % 4]
			print(new_enemy.position)
		play_space.add_child(new_enemy)
		
		
		
		
