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
	pass # Replace with function body.

func trigger() -> void:
	visible = true
	$AnimationPlayer.play("show")
