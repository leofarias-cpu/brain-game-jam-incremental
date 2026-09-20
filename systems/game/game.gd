class_name Game extends Node2D

@export_group("Player", "player_")
@export var player: Player
@export var player_hp_max := 2:
	set(v):
		player_hp_max = v
		hp_max_changed.emit(v)
@export var player_speed := 60.0

@export_group("Play Space", "play_space_")
@export var play_space: PlaySpace
@export var play_space_height: int
@export var play_space_width: int
@export var play_space_border_width: int

@export_group("")
@export var enemies: Array[PackedScene]
@export var safe_time: int = 10
@export var timeout_score := 0.1
#@export var upgrades: Dictionary[PackedScene, int]
@export var going_crazy_timer: Timer
@export var round_end_position: Marker2D
@export var round_start_position: Marker2D

@export_group("Enemy Stats")
@export var ball_stats: BallStats
@export var shooter_stats: ShooterStats
var next_shooter_direction = 1

@export_group("UI")
@export var ui_layer: UI
@export var background: Sprite2D
@export var shop: Shop


var money: int = 0:
	set(v):
		money = v
		money_set.emit(v)

var score := 0:
		set(v):
			score = v
			score_set.emit(v)

signal money_set(value: int)
signal score_set(value: int)
signal play_space_size_changed(space: PlaySpace)
signal hp_max_changed(v: int)

func _ready() -> void:

	
	set_play_space_size(play_space_height, play_space_width, play_space_border_width)
	for enemy in enemies:
		add_enemy(enemy)
	round_start()

func round_start() -> void:
	await get_tree().create_timer(0.5).timeout
	
	background.reset_gradient()
	play_space.reset_border_color()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(play_space, 'position', round_start_position.position, 0.5)
	
	ui_layer.close_shop()
	
	setup_player()
	reset_enemies()
	setup_timer()
	
	score = 0

func round_end() -> void:
	ui_layer.stop_timer()
	money += score
	
	await get_tree().create_timer(0.5).timeout
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(play_space, 'position', round_end_position.position, 0.5)
	set_evil_grazing(false)
	ui_layer.show_shop()
	
func add_enemy(enemy_scene: PackedScene):
	var enemy = enemy_scene.instantiate()
	
	const directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
	var direction: Vector2 = directions.pick_random()
	
	enemy.position = play_space.get_point_from_side(direction, 0.4)
	
	if enemy is EvilBall:
		enemy.graze.connect(_on_player_graze)
	if enemy is Ball:
		enemy.set_stats(ball_stats)
	elif enemy is Shooter:
		enemy.stats = shooter_stats
		enemy.game = self
	
		enemy.direction = next_shooter_direction
		play_space_size_changed.connect(enemy.on_play_space_size_changed)
		
		next_shooter_direction *= -1
		
	if enemy.has_method("go_crazy"):
		going_crazy_timer.timeout.connect(enemy.go_crazy)
	
	play_space.add_child(enemy)

func reset_enemies():
	var enemies_list =  get_tree().get_nodes_in_group("enemies")
	for i in enemies_list.size():
		var enemy = enemies_list[i]
		enemy.reset()
		
		if enemy is Ball:
			const directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
			var direction: Vector2 = directions[i % 4]
			get_tree().create_tween().tween_property(enemy, "position", play_space.get_point_from_side(direction, 0.4), 1)


func setup_player() -> void:
	player.invincible = true
	
	player.hp = player_hp_max
	player.speed = player_speed
	player.position = round_start_position.position
	
	await get_tree().create_timer(1).timeout
	player.invincible = false
	

func setup_timer() -> void:
	await get_tree().create_timer(1).timeout # Grace period for spawned enemies
	going_crazy_timer.start(safe_time)
	ui_layer.start_timer(safe_time)

func set_play_space_size(height: int, width: int, border_width: int):
	self.play_space_height = height
	self.play_space_width = width
	self.play_space_border_width = border_width
	
	play_space.height = height
	play_space.width = width
	play_space.border_width = border_width
	
	play_space_size_changed.emit(play_space)
	play_space.update_size()
	
func increase_play_space_size(height: int, width: int, border_width: int = 0):
	self.play_space_height += height
	self.play_space_width += width
	self.play_space_border_width += border_width
	
	play_space.height += height
	play_space.width += width
	play_space.border_width += border_width
	
	play_space_size_changed.emit(play_space)
	play_space.update_size()
	
	
func _on_player_died() -> void:
	round_end()
	going_crazy_timer.stop()
	player.position.y = -1000


func _on_player_graze(value: int) -> void:
	score += value

func add_upgrade(upgrade: Upgrade):
	shop.add_upgrade(upgrade)

func remove_ball():
	var enemies_list =  get_tree().get_nodes_in_group("enemies")
	for enemy in enemies_list:
		if enemy is Ball:
			enemy.queue_free()
			return 
			
func set_evil_grazing(v: bool):
	var enemies_list =  get_tree().get_nodes_in_group("enemies")
	for enemy in enemies_list:
		if enemy is EvilBall:
			enemy.graze_area.monitoring = v
			if v: enemy.grazing_enabled = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if TranslationServer.get_locale() == 'en':
			TranslationServer.set_locale("pt")
		else:
			TranslationServer.set_locale("en")
		


func _on_going_crazy_timer_timeout() -> void:
	ui_layer.play_timeout_score_effect(score * timeout_score)
	score *= 1 + timeout_score
