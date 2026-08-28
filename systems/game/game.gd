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

@export_group("Enemy Stats")
@export var ball_stats: BallStats

@export_group("UI")
@export var timer_ui: TimerLabel
@export var v_box_container: VBoxContainer
@export var money_ui: RichTextLabel
@export var background: Sprite2D

var money: int = 0
var score := 0

func _ready() -> void:
	play_space.height = play_space_height
	play_space.width = play_space_width
	play_space.border_width = play_space_border_width
	play_space.update_size()
	
	round_start()

func round_start() -> void:
	background.reset_gradient()
	setup_player()
	clear_enemies()
	spawn_enemies()
	setup_timer()
	score = 0

func round_end() -> void:
	timer_ui.stop()
	money += score # TODO: signal on bofa
	
	await get_tree().create_timer(0.5).timeout
	# TODO: Move all this logic onto a script on the canvas layer.
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(play_space, 'position', round_end_position.position, 0.5)
	tween.tween_property(v_box_container, 'offset_transform_position', Vector2(-round_end_position.position.x - 40, 0), 0.5)
	tween.tween_property(money_ui, 'offset_transform_position', Vector2(-round_end_position.position.x - 40, 0), 0.5)
	tween.tween_property(money_ui, 'scale', Vector2(1.5, 1.5), 1)
	# -40 because of the margin oh god
	
	tween.tween_property(money_ui, 'text', "$" + str(money), 2)
	
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
	player.position = play_space.position

func setup_timer() -> void:
	await get_tree().create_timer(1).timeout # Grace period for spawned enemies
	going_crazy_timer.start(safe_time)
	timer_ui.start(safe_time)

func _on_player_died() -> void:
	round_end()
	going_crazy_timer.stop()
	player.position.y = -1000


func _on_player_graze(value: int) -> void:
	score += value
