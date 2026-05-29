extends Node2D

func _ready() -> void:
	%IntroPlayer.animation_finished.connect(on_anim_finished)
	%TitleLabel.text = tr("day" + str(Global.day))

func on_anim_finished(_anim_name: String) -> void:
	Dialogic.timeline_ended.connect(timeline_end)
	Dialogic.start("res://timeline/day" + str(Global.day) + ".dtl")

func timeline_end() -> void:
	if Global.day >= 6:
		var tween: Tween = create_tween()
		tween.tween_property($Clark, "position", Vector2(300, 568), 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Clark, "rotation_degrees", -90, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Clark/ColorRect, "color", Color(1, 1, 1, 1), 1.5)
		await tween.finished
		await get_tree().create_timer(3.0).timeout
		Transition.transition()
		await Transition.transition_finished
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
		return
	Global.go_to_minigame(Global.minigames[Global.day])
