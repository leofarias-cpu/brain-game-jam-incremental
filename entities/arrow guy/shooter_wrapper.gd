class_name Shooter extends Node2D

@export var lower_bound: float = -100:
	set(v): arrow_guy.lower_bound = v
@export var upper_bound: float = 100:
	set(v): arrow_guy.upper_bound = v

@export var stats: ShooterStats:
	set(v): arrow_guy.stats = v

@export var game: Game 

@export var arrow_guy: Shooter_inner
@export var hand: Sprite2D
@export var direction := -1:
	set(v):
		arrow_guy.direction_x = v
		direction = v
		hand.direction = v

func _ready():
	reset()

func reset():
	if direction == -1:
		position.x -= game.play_space_width / 2 - 30
	else:
		position.x += game.play_space_width / 2 + 30
	arrow_guy.reset()
	hand.reset()
	
func go_crazy():
	arrow_guy.go_crazy()
