class_name Game extends Node2D

@export_group("Player", "player_")
@export var player: Player
@export var player_hp_max := 2
@export var player_speed := 60.0

@export_group("Play Space", "play_space_")
@export var play_space: PlaySpace
@export var play_space_height: float
@export var play_space_width: float
@export var play_space_border_width: float

@export_group("")
@export var enemies: Array[PackedScene]
@export var safe_time: int = 10
#@export var upgrades: Dictionary[PackedScene, int]
@export var going_crazy_timer: Timer
@export var round_end_position: Marker2D
@export var round_start_position: Marker2D

@export_group("Enemy Stats")
@export var ball_stats: BallStats

@export_group("UI")
@export var ui_layer: UI
@export var background: Sprite2D


var money: int = 0:
	set(v):
		money = v
		print(money)
		money_set.emit(v)

var score := 0:
		set(v):
			score = v
			score_set.emit(v)

signal money_set(value: int)
signal score_set(value: int)

func _ready() -> void:
	play_space.height = play_space_height
	play_space.width = play_space_width
	play_space.border_width = play_space_border_width
	play_space.update_size()
	
	round_start()

func round_start() -> void:
	background.reset_gradient()
	
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(play_space, 'position', round_start_position.position, 0.5)
	ui_layer.close_shop()
	
	setup_player()
	clear_enemies()
	spawn_enemies()
	setup_timer()
	
	score = 0

func round_end() -> void:
	ui_layer.stop_timer()
	money += score
	
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(play_space, 'position', round_end_position.position, 0.5)
	
	ui_layer.show_shop()
	
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
		
		if new_enemy.has_method("go_crazy"):
			going_crazy_timer.timeout.connect(new_enemy.go_crazy)
		
		play_space.add_child(new_enemy)

func clear_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.queue_free()

func setup_player() -> void:
	player.hp = player_hp_max
	player.speed = player_speed
	player.position = round_start_position.position
	

func setup_timer() -> void:
	await get_tree().create_timer(1).timeout # Grace period for spawned enemies
	going_crazy_timer.start(safe_time)
	ui_layer.start_timer(safe_time)

func _on_player_died() -> void:
	round_end()
	going_crazy_timer.stop()
	player.position.y = -1000


func _on_player_graze(value: int) -> void:
	score += value
