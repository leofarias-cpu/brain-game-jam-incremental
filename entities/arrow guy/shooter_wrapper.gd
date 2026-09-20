class_name Shooter extends Node2D

@export var lower_bound: float = -100:
	set(v): arrow_guy.lower_bound = v
@export var upper_bound: float = 100:
	set(v): arrow_guy.upper_bound = v

@export var stats: ShooterStats

@export var game: Game 

@export var arrow_guy: Shooter_inner
@export var hand: Sprite2D
@export var direction := -1:
	set(v):
		arrow_guy.direction_x = v
		arrow_guy.direction_y = v
		direction = v
		hand.direction = v

func _ready():
	reset()

func reset():
	var play_space: PlaySpace = game.play_space
	arrow_guy.stats = stats
	if direction == 1:
		position.x = -play_space.width / 2 - 30 + play_space.border_width
	else:
		position.x = play_space.width / 2 + 30 - play_space.border_width
	
	lower_bound = play_space.global_position.y -play_space.height / 2 + play_space.border_width
	upper_bound = play_space.global_position.y + play_space.height / 2 - play_space.border_width
	
	print("Resetaivos o cara")
	arrow_guy.reset()
	hand.reset()
	
func go_crazy():
	arrow_guy.go_crazy()

func on_play_space_size_changed(space: PlaySpace):
	var target_pos: float
	
	if direction == 1:
		target_pos = -space.width / 2 - 30 + space.border_width
	else:
		target_pos = space.width / 2 + 30 - space.border_width
		
		
	get_tree().create_tween().tween_property(self, 'position', Vector2(target_pos, position.y), 1)
