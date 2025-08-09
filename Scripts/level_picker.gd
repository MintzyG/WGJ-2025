extends Control

const MAIN_MENU = preload("res://Nodes/Menus/MainMenu.tscn")
func _on_button_pressed() -> void:
	if !SceneManager.is_transitioning:
		SceneManager.change_scene(
			MAIN_MENU, {
				"pattern_enter": "curtains",
				"pattern_leave": "circle",
			}
		)

func get_levels_from_folder(path: String) -> Array:
	var levels: Array = []
	var dir := DirAccess.open(path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tscn"):
				var full_path = path.path_join(file_name)
				levels.append(full_path)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Could not open directory: " + path)

	return levels

func _ready():
	var level_paths = get_levels_from_folder("res://Nodes/Maps/")
	for l in level_paths:
		var b = Button.new()
		b.text = l.get_file().get_basename()
		b.set_meta("scene", load(l)) # store PackedScene in metadata
		b.pressed.connect(_on_level_button_pressed.bind(b))
		%Levels.add_child(b)

func _on_level_button_pressed(button: Button):
	var scene: PackedScene = button.get_meta("scene")
	if !SceneManager.is_transitioning:
		SceneManager.change_scene(
			scene, {
				"pattern_enter": "curtains",
				"pattern_leave": "circle",
			}
		)
