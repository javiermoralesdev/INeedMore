extends Control

func _ready() -> void:
	Global.free_mode = false
	if OS.get_name() == "Android":
		$UILayer/MainMenu/ExitButton.queue_free()
		$UILayer/SettingsMenu/VBoxContainer/FullscreenSelector.visible = false
	$UILayer/MainMenu/ContinueButton.text = tr("mm_continue") + " - " + tr("chapter") + " " + str(Global.day)
	$UILayer/SettingsMenu/VBoxContainer/MusicSelector.change_value(Global.music_volume * 10)
	$UILayer/SettingsMenu/VBoxContainer/SoundSelector.change_value(Global.sound_volume * 10)
	$UILayer/SettingsMenu/VBoxContainer/AmbientSelector.change_value(Global.ambient_volume * 10)
	$UILayer/SettingsMenu/VBoxContainer/FullscreenSelector.change_value(1 if Global.fullscreen else 0)
	$UILayer/SettingsMenu/VBoxContainer/LanguageSelector.change_value(0 if Global.language == "en" else 1)

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


func _on_free_mode_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/MainMenu.visible = false
	$UILayer/FreeModeMenu.visible = true


func _on_settings_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/MainMenu.visible = false
	$UILayer/SettingsMenu.visible = true

func _on_credits_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/MainMenu.visible = false
	$UILayer/Credits.visible = true


func _on_free_mode_back_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/FreeModeMenu.visible = false
	$UILayer/MainMenu.visible = true

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		$UILayer/MainMenu/ContinueButton.text = tr("mm_continue") + " - " + tr("chapter") + " " + str(Global.day)

func change_settings(_value: int, _data: String) -> void:
	Global.update_settings(
		($UILayer/SettingsMenu/VBoxContainer/MusicSelector.value as float)/10, 
		($UILayer/SettingsMenu/VBoxContainer/SoundSelector.value as float)/10, 
		($UILayer/SettingsMenu/VBoxContainer/AmbientSelector.value as float)/10, 
		true if $UILayer/SettingsMenu/VBoxContainer/FullscreenSelector.value == 1 else false, 
		"en" if $UILayer/SettingsMenu/VBoxContainer/LanguageSelector.value == 0 else "es"
	)
	Global.save_game()


func _on_settings_back_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/SettingsMenu.visible = false
	$UILayer/MainMenu.visible = true


func _on_credits_back_button_pressed() -> void:
	Transition.transition()
	await Transition.transition_finished
	$UILayer/Credits.visible = false
	$UILayer/MainMenu.visible = true
