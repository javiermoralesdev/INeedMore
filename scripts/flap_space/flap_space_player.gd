extends CharacterBody2D

const JUMP_VELOCITY: float = -200.0
const gravity: float = 5
const FALL_THRESSHOLD: int = 100

@onready var jump_texture: Texture = preload("res://sprites/flap_space/Jump (32x32).png")
@onready var fall_texture: Texture = preload("res://sprites/flap_space/Fall (32x32).png")
var dead: bool = false 
var start: bool = false

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		if start:
			velocity.y += gravity
	else:
		dead = true
		$PlayerSprite.modulate = Color.DARK_RED
		velocity.y = 0
	
	if Input.is_action_just_pressed("tap") and not dead:
		velocity.y = JUMP_VELOCITY
		start = true
	if velocity.y < 0:
		$PlayerSprite.texture = jump_texture
	if velocity.y > FALL_THRESSHOLD:
		$PlayerSprite.texture = fall_texture
	move_and_slide()
