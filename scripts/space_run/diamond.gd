extends Area2D


var player: SpaceRunPlayer

func _process(delta: float) -> void:
	if not player.start or player.dead:
		return
	position.x -= player.speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is SpaceRunPlayer:
		(body as SpaceRunPlayer).add_score(1)
		queue_free()
