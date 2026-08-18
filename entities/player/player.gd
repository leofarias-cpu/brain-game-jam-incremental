extends CharacterBody2D


@export var SPEED = 30.0

func _physics_process(delta: float) -> void:

	var direction_x := Input.get_axis("left", "right")
	var direction_y := Input.get_axis("up", "down")
	
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = 0
		
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = 0
	move_and_slide()
