class_name SkyRisePlayer
extends CharacterBody2D

const GRAVITY: float = 300.0

var start: bool = false
var dead: bool = false
var pressing: bool = false
var score: int = 0

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
		velocity.x = 0
	queue_redraw()
	if Input.is_action_just_pressed("tap") and not dead:
		mouseDown = get_global_mouse_position()
		if not start:
			start = true
			%StartLabel.queue_free()
			%SpawnTimer.start()
		pressing = true
	if Input.is_action_just_released("tap") and not dead:
		jump()
	if position.x > 255 or position.x < -255:
		velocity.x *= -1
	move_and_slide()

func jump() -> void:
	pressing = false
	var direction: Vector2 = get_global_mouse_position() - mouseDown
	velocity = direction * 3.5
	%JumpPlayer.play()

func _draw() -> void:
	if not pressing:
		return
	draw_line(to_local(position), to_local((get_global_mouse_position() - mouseDown) + position), Color.RED, 3)


func _on_spawn_timer_timeout() -> void:
	var platform_instance: SkyRisePlatform = platform_prefab.instantiate()
	platform_instance.position.x = randi_range(-200, 200)
	platform_instance.position.y = -300
	platform_instance.player = self
	get_parent().add_child(platform_instance)


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body is SkyRisePlatform:
		(body as SkyRisePlatform).trigger()
	if body is not SkyRisePlayer:
		return
	if dead:
		return
	dead = true
	%SpawnTimer.stop()
	modulate = Color.DARK_RED
	if  score > Global.skyrise_high_score:
		Global.skyrise_high_score = score
	%GameOverScreen.trigger(score, Global.skyrise_high_score, 5)

func add_score(amount: int) -> void:
	score += amount
	%ScoreLabel.text = str(score)
	%CoinPlayer.play()
