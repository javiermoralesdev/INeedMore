extends Control

func _on_flap_space_pressed() -> void:
	go_to_minigame("flap_space")


func _on_space_run_pressed() -> void:
	go_to_minigame("space_run")


func _on_snake_pressed() -> void:
	go_to_minigame("snake")


func _on_sky_rise_pressed() -> void:
	go_to_minigame("sky_rise")


func _on_final_battle_pressed() -> void:
	go_to_minigame("final_battle")

func go_to_minigame(target: String) -> void:
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_file("res://scenes/" + target +  "/" + target + ".tscn")
