extends Control

const LEVEL_1 = preload("res://Nodes/Maps/Level1.tscn")

func _on_button_pressed() -> void:
	if !SceneManager.is_transitioning:
		SceneManager.change_scene(
			LEVEL_1, {
				"pattern_enter": "curtains",
				"pattern_leave": "circle",
			}
		)
		
const LEVEL_PICKER = preload("res://Nodes/Menus/LevelPicker.tscn")
func _on_level_picker_pressed() -> void:
	if !SceneManager.is_transitioning:
		SceneManager.change_scene(
			LEVEL_PICKER, {
				"pattern_enter": "curtains",
				"pattern_leave": "circle",
			}
		)
