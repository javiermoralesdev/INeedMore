class_name Arrow
extends Area2D

var player: FinalBattlePlayer

func _process(delta: float) -> void:
	position += transform.x * player.force * delta
