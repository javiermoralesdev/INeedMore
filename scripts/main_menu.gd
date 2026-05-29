extends Control

func _ready() -> void:
	Global.free_mode = false
	if OS.get_name() == "Android":
		$UILayer/MainMenu/ExitButton.queue_free()
	$UILayer/MainMenu/ContinueButton.text = tr("mm_continue") + " - " + tr("chapter") + " " + str(Global.day)


func _on_play_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	Global.day = 1
	Global.save_game()
	get_tree().change_scene_to_file("res://scenes/real_life.tscn")

func _on_continue_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_file("res://scenes/real_life.tscn")


func _on_exit_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().quit()
