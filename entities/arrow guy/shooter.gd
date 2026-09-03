class_name Shooter_inner extends CharacterBody2D

@export var lower_bound: float = -100
@export var upper_bound: float = 100

@export var bullet_scene: PackedScene
var flying_bullets: Array[Bullet]
var free_bullets: Array[Bullet]

@export var bullet_spawn_point: Marker2D

@export var stats: ShooterStats
@export var hand: Sprite2D

var direction_y := 1
var direction_x := 1

func _ready():
	reset()

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * direction_y * delta)
	if direction_y == 1 and global_position.y >= upper_bound:
		direction_y = -1
	elif direction_y == -1 and global_position.y <= lower_bound:
		direction_y = 1

func shoot():
	velocity.y = 0
	await hand.in_position
	
	for b in free_bullets:
		var bullet: Bullet = free_bullets.pop_front()
		
		bullet.global_position = bullet_spawn_point.global_position
		bullet.rotation = rotation
		bullet.stats = stats.bullet_stats
		bullet.visible = true
		bullet.disabled = false
		bullet.direction = direction_x
		
		flying_bullets.push_back(bullet)
		var tween = get_tree().create_tween()
		tween.tween_property(hand, "position", Vector2(position.x + 9 * direction_x, position.y), 0.1)
		tween.tween_property(hand, "position", Vector2(position.x + 14 * direction_x, position.y), 0.1)
		await get_tree().create_timer(0.2).timeout
	velocity.y = stats.speed
	
func add_bullet():
	var bullet: Bullet = bullet_scene.instantiate()
	
	bullet.stats = stats.bullet_stats
	bullet.visible = false
	bullet.disabled = true
	
	free_bullets.push_back(bullet)
	get_parent().add_child.call_deferred(bullet)
	bullet.hit.connect(reset_bullet)
	
func reset():
	var diff = stats.bullet_amount - (free_bullets.size() + flying_bullets.size())
	if diff > 0:
		for i in diff:
			add_bullet()
	
	velocity.y = stats.speed * randf_range(0.5, 2)
	await get_tree().create_timer(0.5).timeout
	velocity.y = stats.speed
	shoot()

func reset_bullet(bullet: Bullet):
	bullet.position = self.position
	bullet.visible = false
	bullet.disabled = true
	bullet.go_crazy = false
	
	free_bullets.push_back(bullet)
	if free_bullets.size() == stats.bullet_amount:
		shoot()

func go_crazy():
	for bullet in free_bullets:
		bullet.go_crazy = true
	for bullet in flying_bullets:
		bullet.go_crazy = true
