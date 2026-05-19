class_name FinalBattlePlayer
extends Area2D

const BASE_SPEED: int = 300

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var arrow_prefab: PackedScene = preload("res://scenes/final_battle/arrow.tscn")
@onready var enemy_prefab: PackedScene

var start: bool = false 
var dead:bool = false
var force: int = 300
var global_speed: int = BASE_SPEED

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
			%SpawnTimer.start()

func shoot() -> void:
	var arrow: Arrow = arrow_prefab.instantiate()
	arrow.rotation = rotation
	arrow.position = position
	arrow.player = self
	get_parent().add_child(arrow)

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
	pass
