extends ColorRect

@onready var main_menu: PackedScene = preload("res://scenes/main_menu.tscn")

func _ready() -> void:
	visible = false

func _on_retry_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_packed(main_menu)


func _on_end_day_button_pressed() -> void:
	if Global.day <= Global.free_mode_day:
		Global.free_mode_day += 1
	Global.day += 1
	Global.save_game()
	Transition.transition()
	await Transition.transition_finished
	if Global.day == 4:
		get_tree().change_scene_to_file("res://scenes/chapter4_interlude.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/real_life.tscn")

func trigger(score: int, high_score: int, target: int) -> void:
	visible = true
	$ScoreLabel.text = tr("score") + ": " + str(score)
	Global.save_game()
	$HighScoreLabel.text = tr("hscore") + ": " + str(high_score)
	if high_score < target or Global.free_mode:
		$EndDayButton.queue_free()
	$AnimationPlayer.play("show")
