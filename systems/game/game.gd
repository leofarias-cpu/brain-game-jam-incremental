extends Node2D

@export var hp = 3:
	set(value):
		hp = value
		if hp <= 0:
			get_tree().paused = true

@export var play_space_height: float
@export var play_space_wdith: float
@export var play_space_border_width: float
@export var play_space: PlaySpace

func _ready() -> void:
	#get_tree().paused = true
	play_space.height = play_space_height
	play_space.width = play_space_wdith
	play_space.border_width = play_space_border_width
	play_space.update_size()
	#get_tree().paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		play_space.height += 32
		play_space.width += 32
		play_space.update_size()

func _on_player_hit() -> void:
	hp -= 1
