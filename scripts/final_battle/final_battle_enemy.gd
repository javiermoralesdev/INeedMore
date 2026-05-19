extends Area2D

var player: FinalBattlePlayer

func _process(delta: float) -> void:
	var direction: Vector2 = (player.position - global_position).normalized()
	global_position += direction * player.global_speed * delta
