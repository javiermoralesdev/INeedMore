extends VBoxContainer

signal value_changed(value: int, data: String)

@export var setting_title: String
@export var options: Array[String]
@export var value: int

func _ready() -> void:
	$SettingTitle.text = tr(setting_title)
	$HBoxContainer/DataLabel.text = tr(options[value])

func _hover() -> void:
	$HoverPlayer.play()


func _on_left_button_pressed() -> void:
	$ClickPlayer.play()
	value -= 1
	if value == -1:
		value = options.size() -1
	$HBoxContainer/DataLabel.text = tr(options[value])
	value_changed.emit(value, options[value])

func _on_right_button_pressed() -> void:
	$ClickPlayer.play()
	value += 1
	if value == options.size():
		value = 0
	$HBoxContainer/DataLabel.text = tr(options[value])
	value_changed.emit(value, options[value])

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		$SettingTitle.text = tr(setting_title)
		$HBoxContainer/DataLabel.text = tr(options[value])

func change_value(p_value: int) -> void:
	value = p_value
	$SettingTitle.text = tr(setting_title)
	$HBoxContainer/DataLabel.text = tr(options[value])
