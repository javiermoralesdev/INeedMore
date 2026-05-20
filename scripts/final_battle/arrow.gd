class_name Arrow
extends Area2D

var player: FinalBattlePlayer

func _process(delta: float) -> void:
	position += transform.x * player.force * delta


func _on_area_entered(area: Area2D) -> void:
	if area is not FinalBattlePlayer:
		queue_free()
