class_name FlapSpacePlayer
extends CharacterBody2D

const JUMP_VELOCITY: float = -200.0
const gravity: float = 5
const FALL_THRESSHOLD: int = 100
const BASE_SPEED: int = 100

var pipe_speed: int = 100
var points: int = 0

@onready var jump_texture: Texture = preload("res://sprites/flap_space/Jump (32x32).png")
@onready var fall_texture: Texture = preload("res://sprites/flap_space/Fall (32x32).png")
@onready var pipe_prefab: PackedScene = preload("res://scenes/flap_space/pipe.tscn");

var dead: bool = false 
var start: bool = false

func _physics_process(_delta: float) -> void:
	var new_speed: int = BASE_SPEED + (points * 10)
	pipe_speed = new_speed
	if start and not dead:
		%BackgroundTexture.material.set_shader_parameter("motion", Vector2(new_speed, 0))
	
	if not is_on_floor():
		if start:
			velocity.y += gravity
	else:
		die()
		velocity.y = 0
	
	if Input.is_action_just_pressed("tap") and not dead:
		velocity.y = JUMP_VELOCITY
		if not start:
			start = true
			%SpawnTimer.start()
	if velocity.y < 0:
		$PlayerSprite.texture = jump_texture
	if velocity.y > FALL_THRESSHOLD:
		$PlayerSprite.texture = fall_texture
	move_and_slide()

func die() -> void:
	pipe_speed = 0
	dead = true
	$PlayerSprite.modulate = Color.RED
	%BackgroundTexture.material.set_shader_parameter("motion", Vector2.ZERO)


func _on_spawn_timer_timeout() -> void:
	var pipe_instance: Area2D = pipe_prefab.instantiate()
	pipe_instance.position = Vector2(500, 0);
	get_tree().root.add_child(pipe_instance)
	print("Generación")
