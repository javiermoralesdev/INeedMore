class_name FinalBattleMovingObject
extends Area2D

var player: FinalBattlePlayer

func _process(delta: float) -> void:
	if player.dead:
		return
	var direction: Vector2 = (player.position - global_position).normalized()
	global_position += direction * player.global_speed * delta

func process_collision(area: Area2D) -> void:
	if area is Arrow:
		(get_node("/root/FinalBattle/BreakPlayer") as AudioStreamPlayer).play()
		queue_free()
