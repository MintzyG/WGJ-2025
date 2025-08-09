extends Area2D

@export var next_level: PackedScene
@export var pattern_enter: String = "curtains"
@export var pattern_leave: String = "circle"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.stop = true
		if !SceneManager.is_transitioning:
			audio_stream_player.play()
			await audio_stream_player.finished
			SceneManager.change_scene(
				next_level, {
					"pattern_enter": pattern_enter,
					"pattern_leave": pattern_leave,
				}
			)
			
