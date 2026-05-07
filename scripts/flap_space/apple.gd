extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is FlapSpacePlayer:
		(body as FlapSpacePlayer).points += 1
		queue_free()
