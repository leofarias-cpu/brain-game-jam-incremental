class_name Game extends Node2D

@export_group("Player")
@export var player: Player
@export var player_hp_max := 2
@export var player_speed := 60.0

@export_group("Play Space")
@export var play_space_height: float
@export var play_space_width: float
@export var play_space_border_width: float
@export var play_space: PlaySpace

@export_group("")
@export var enemies: Array[PackedScene]
#@export var upgrades: Dictionary[PackedScene, int]

@export_group("Enemy Stats")
@export var ball_stats: BallStats

func _ready() -> void:
	play_space.height = play_space_height
	play_space.width = play_space_width
	play_space.border_width = play_space_border_width
	play_space.update_size()
	
	round_start()

func _process(_delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		play_space.height += 32
		play_space.width += 32
		play_space.update_size()

func round_start() -> void:
	setup_player()
	clear_enemies()
	spawn_enemies()

func round_end() -> void:
	pass
	

func spawn_enemies() -> void:
	for i in enemies.size():
		var scene = enemies[i]
		var new_enemy = scene.instantiate()
		
		if new_enemy is Node2D:
			const directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
			
			var direction: Vector2 = directions[i % 4]
			
			new_enemy.position = play_space.get_point_from_side(direction, 0.4)
			new_enemy.rotation = direction.angle()
			new_enemy.add_to_group('enemies')
			print(new_enemy.position)
		
		if new_enemy is Ball:
			new_enemy.stats = ball_stats
		
		play_space.add_child(new_enemy)

func clear_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()

func setup_player() -> void:
	player.hp = player_hp_max
	player.speed = player_speed
	player.position = play_space.position


func _on_player_died() -> void:
	round_end()
