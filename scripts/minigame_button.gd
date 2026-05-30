extends Control

@export var day: int
@export var minigame: Texture
@export var title: String
@export var scene: PackedScene
@onready var locked_texture: Texture = preload("res://images/half_locked.png")

func _ready() -> void:
	$VBoxContainer/MinigameLabel.text = title if Global.free_mode_day > day  else tr("locked")
	$VBoxContainer/MinigameImage.texture_normal = minigame if Global.free_mode_day > day  else locked_texture
	if Global.free_mode_day <= day:
		$VBoxContainer/ScoreLabel.visible = false
	var score: int = 0
	match day:
		1:
			score = Global.flap_space_high_score
		2:
			score = Global.space_run_high_score
		3:
			score = Global.snake_high_score
		4:
			score = Global.skyrise_high_score
		5:
			score = Global.final_battle_high_score
	$VBoxContainer/ScoreLabel.text = tr("score") + ": " + str(score)
func _on_minigame_image_mouse_entered() -> void:
	if Global.free_mode_day <= day:
		return
	$HoverPlayer.play()




func _on_minigame_image_pressed() -> void:
	if Global.free_mode_day <= day:
		return
	$ClickPlayer.play()
	Global.free_mode = true
	Transition.transition()
	await Transition.transition_finished
	get_tree().change_scene_to_packed(scene)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		$VBoxContainer/MinigameLabel.text = title if Global.free_mode_day > day  else tr("locked")
