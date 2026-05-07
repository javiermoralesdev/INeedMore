extends Area2D

@onready var player: FlapSpacePlayer

func _ready() -> void:
	position.y = randi_range(-70, 80)
	

func _process(delta: float) -> void:
	if not %Player.start:
		return
	position.x += -%Player.pipe_speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is FlapSpacePlayer:
		(body as FlapSpacePlayer).die()
