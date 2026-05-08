extends CanvasLayer

signal transition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	anim_player.animation_finished.connect(_on_anim_finished)

func transition() -> void:
	color_rect.visible = true
	anim_player.play("fade_to_black")

func _on_anim_finished(anim_name: String) -> void:
	if anim_name == "fade_to_black":
		anim_player.play("fade_to_normal")
		transition_finished.emit()
	else:
		color_rect.visible = false
