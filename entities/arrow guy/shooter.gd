class_name Shooter extends CharacterBody2D

@export var lower_bound: float = -100
@export var upper_bound: float = 100

		
@export var bullet_scene: PackedScene
@export var bullets_group: Node2D
@export var bullet_spawn_point: Marker2D

@export var animation_player: AnimationPlayer
@export var stats: ShooterStats
@export var cooldown_timer: Timer

var direction := 1

func _ready():
	reset()

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * direction * delta)
	if direction == 1 and global_position.y >= upper_bound:
		direction = -1
	elif direction == -1 and global_position.y <= lower_bound:
		direction = 1

func shoot():
	for bullet: Bullet in bullets_group.get_children():
		bullet.position = bullet_spawn_point.global_position
		bullet.rotation = rotation
		bullet.stats = stats.bullet_stats
		bullet.visible = true
		bullet.disabled = false
		await get_tree().create_timer(0.2).timeout
	
func add_bullet():
	var bullet: Bullet = bullet_scene.instantiate()
	bullets_group.add_child(bullet)
	bullet.hit.connect(reset_bullet)
	
func reset():
	cooldown_timer.wait_time = stats.shooting_cooldown
	cooldown_timer.start()
	
	var diff = stats.bullet_amount - bullets_group.get_child_count() 
	if diff > 0:
		for i in diff:
			add_bullet()
	
	velocity.y = stats.speed

func reset_bullet(bullet: Bullet):
	bullet.position = self.position
	bullet.visible = false
	bullet.disabled = true
