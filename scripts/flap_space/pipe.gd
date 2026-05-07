extends Area2D


func _process(delta: float) -> void:
	position.x += -200*delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$DeathTimer.start()


func _on_death_timer_timeout() -> void:
	queue_free()
