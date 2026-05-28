extends CanvasLayer

func _ready() -> void:
	Dialogic.timeline_ended.connect(on_timeline_end)
	Dialogic.start(load("res://timeline/interlude.dtl"))

func on_timeline_end() -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_file("res://scenes/real_life.tscn")
