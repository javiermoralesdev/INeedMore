class_name SkyRisePlayer
extends CharacterBody2D


const GRAVITY: float = 350.0

var start: bool = false
var dead: bool = false
var pressing: bool = false

var mouseDown: Vector2

@onready var platform_prefab: PackedScene = preload("res://scenes/sky_rise/platform.tscn")

func _ready() -> void:
	%StartPlatform.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
	queue_redraw()
	if Input.is_action_just_pressed("tap"):
		mouseDown = get_global_mouse_position()
		if not start:
			start = true
		pressing = true
	if Input.is_action_just_released("tap"):
		jump()
	if position.x > 255 or position.x < -255:
		velocity.x *= -1
	move_and_slide()

func jump() -> void:
	pressing = false
	var direction: Vector2 = get_global_mouse_position() - mouseDown
	velocity = direction * 3.5

func _draw() -> void:
	if not pressing:
		return
	draw_line(to_local(position), to_local((get_global_mouse_position() - mouseDown) + position), Color.RED, 3)


func _on_spawn_timer_timeout() -> void:
	var platform_instance: Node2D = platform_prefab.instantiate()
