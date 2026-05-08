class_name Pipe
extends Area2D

@onready var apple: Node2D = $FlapSpaceApple

var player: FlapSpacePlayer

func _ready() -> void:
	position.y = randi_range(-70, 80)
	
	player.on_die.connect(_destroy_apple_on_endgame)

func _destroy_apple_on_endgame() -> void:
	if is_instance_valid(apple):
		apple.queue_free()

func _process(delta: float) -> void:
	if not player.start or player.dead:
		return
	position.x += -player.pipe_speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is FlapSpacePlayer:
		(body as FlapSpacePlayer).die()
