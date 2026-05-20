class_name FinalBattleKiwi
extends FinalBattleMovingObject



func _on_area_entered(area: Area2D) -> void:
	process_collision(area)
	if area is FinalBattlePlayer:
		(area as FinalBattlePlayer).add_score(1)
		queue_free()
