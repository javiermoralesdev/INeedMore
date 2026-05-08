extends Button



func _on_mouse_entered() -> void:
	$HoverPlayer.play()




func _on_pressed() -> void:
	$ClickPlayer.play()
