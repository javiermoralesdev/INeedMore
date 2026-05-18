class_name SpaceRunPlayer
extends CharacterBody2D

@onready var diamond_prefab: PackedScene = preload("res://scenes/space_run/diamond.tscn")
@onready var meteor_prefab: PackedScene = preload("res://scenes/space_run/meteor.tscn")

const BASE_POSITION: int = 373
const INCREMENT: int = 280
const BASE_SPEED: int = 500
const SPEED_FACTOR: int = 20

var score: int
var speed: int = 500
var start: bool = false
var dead: bool = false

var mouse_down: Vector2

func _ready() -> void:
	position.y = BASE_POSITION
	var ship_index: int = randi_range(1, 9)
	$SpaceRunPlayerSprite.texture = load("res://sprites/space_run/Ships/spaceShips_00" + str(ship_index) + ".png")

func move_to(target_pos: Vector2) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", target_pos, 0.2)  # 0.5 = duration in seconds


func _process(_delta: float) -> void:
	var new_speed: int = BASE_SPEED + (score * SPEED_FACTOR)
	speed = new_speed
	
	if Input.is_action_just_pressed("tap"):
		mouse_down = get_global_mouse_position()
		if not start:
			start = true
			%StartLabel.queue_free()
			%HowToPlay.queue_free()
			%SpawnTimer.start()
			%ScoreLabel.visible = true
	
	if Input.is_action_just_released("tap"):
		swipe_action()
	
	if start and not dead:
		%BackgroundTexture.material.set_shader_parameter("motion", Vector2(new_speed, 0))

func swipe_action() -> void:
	var direction: Vector2 = get_global_mouse_position() - mouse_down
	if abs(direction.y) < 10:
		return
	if direction.y > 0:
		move_player("d")
	else:
		move_player("u")

func move_player(dir: String) -> void:
	%MovePlayer.play()
	if position.y < BASE_POSITION + INCREMENT and dir == "d":
		move_to(Vector2(position.x, position.y + INCREMENT))
	
	if position.y > BASE_POSITION - INCREMENT and dir == "u":
		move_to(Vector2(position.x, position.y - INCREMENT))


func _on_spawn_timer_timeout() -> void:
	var chance: int = randi_range(1, 2)
	var instance: Area2D
	if chance == 1:
		instance = diamond_prefab.instantiate()
	else:
		instance = meteor_prefab.instantiate()
	
	instance.player = self
	instance.position.x = 1700
	instance.position.y = BASE_POSITION + (INCREMENT * randi_range(-1, 1))
	get_parent().add_child(instance)

func die() -> void:
	if dead:
		return
	dead = true
	if score > Global.space_run_high_score:
		Global.space_run_high_score = score
	%BackgroundTexture.material.set_shader_parameter("motion", Vector2.ZERO)
	%GameOverScreen.trigger(score, Global.space_run_high_score, 20)
	$SpaceRunPlayerSprite.modulate = Color.RED
	%ScoreLabel.queue_free()

func add_score(amount: int) -> void:
	score += amount
	%CoinPlayer.play()
	%ScoreLabel.text = str(score);
	if score > 3:
		%SpawnTimer.wait_time = 3
	
	if score > 10:
		%SpawnTimer.wait_time = 1.5
