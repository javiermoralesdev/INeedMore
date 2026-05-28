class_name FinalBattlePlayer
extends Area2D

const BASE_SPEED: int = 300

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_prefab: PackedScene = preload("res://scenes/final_battle/arrow.tscn")
@onready var enemy_prefab: PackedScene = preload("res://scenes/final_battle/final_battle_enemy.tscn")
@onready var kiwi_prefab: PackedScene = preload("res://scenes/final_battle/final_battle_kiwi.tscn")

var start: bool = false 
var dead:bool = false
var force: int = 300
var global_speed: int = BASE_SPEED
var score: int = 0

func _process(_delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var lookDir: Vector2 = mouse_pos - position
	var angle: float = atan2(lookDir.y, lookDir.x)
	if start and not dead:
		rotation = angle
	if Input.is_action_just_pressed("tap"):
		if start and not dead:
			shoot()
		if not start:
			start = true
			%StartLabel.queue_free()
			%SpawnTimer.start()

func shoot() -> void:
	var arrow: Arrow = arrow_prefab.instantiate()
	arrow.rotation = rotation
	arrow.position = position
	arrow.player = self
	get_parent().add_child(arrow)
	%ShootPlayer.play()

func random_edge_position() -> Vector2:
	var edge: int = randi_range(0, 3)
	match edge:
		0:  # top
			return Vector2(randf_range(-360, 360), -360)
		1:  # bottom
			return Vector2(randf_range(-360, 360), 360)
		2:  # left
			return Vector2(-360, randf_range(-360, 360))
		3:  # right
			return Vector2(360, randf_range(-360, 360))
	return Vector2.ZERO

func _on_spawn_timer_timeout() -> void:
	var spawn_position: Vector2 = random_edge_position()
	var spawn_chance: int = randi_range(0, 2)
	var instance: FinalBattleMovingObject
	if spawn_chance == 0:
		instance = kiwi_prefab.instantiate()
	else:
		instance = enemy_prefab.instantiate()
	instance.position = spawn_position
	instance.player = self
	get_parent().add_child(instance)

func add_score(amount: int) -> void:
	score += amount
	%ScoreLabel.text = str(score)
	global_speed = BASE_SPEED + (score * 5)
	if score >= 5:
		%SpawnTimer.wait_time = 1.5
	if score >= 10:
		%SpawnTimer.wait_time = 1
	%CoinPlayer.play()

func die() -> void:
	dead = true
	modulate = Color.RED
	if score > Global.final_battle_high_score:
		Global.final_battle_high_score = score
	%GameOverScreen.trigger(score, Global.final_battle_high_score, 30)
	%SpawnTimer.stop()
