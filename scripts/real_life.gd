extends Node2D

func _ready() -> void:
	%IntroPlayer.animation_finished.connect(on_anim_finished)
	%TitleLabel.text = tr("day" + str(Global.day))

func on_anim_finished(_anim_name: String) -> void:
	Dialogic.timeline_ended.connect(timeline_end)
	Dialogic.start("res://timeline/day" + str(Global.day) + ".dtl")
	

func timeline_end() -> void:
	if Global.day >= 6:
		return
	Global.go_to_minigame(Global.minigames[Global.day])
