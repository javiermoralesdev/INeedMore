extends CanvasLayer

func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	$AudioStreamPlayer.play()
	Dialogic.start(load("res://timeline/ending.dtl"))
