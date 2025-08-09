extends Area2D
class_name Collectible

@export var is_star: bool = true
@export var amount: int = 1
@onready var sprite: Sprite2D = %Sprite

@export var star_sprite: Texture2D
@export var anti_matter_sprite: Texture2D
@onready var audio_stream_player_good: AudioStreamPlayer = $AudioStreamPlayerGood
@onready var audio_stream_player_bad: AudioStreamPlayer = $AudioStreamPlayerBad

func _ready() -> void:
	if is_star:
		sprite.texture = star_sprite
	else:
		sprite.texture = anti_matter_sprite

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_star:
			Stats.add_score(amount)
			var temp_audio = audio_stream_player_good.duplicate()
			get_tree().current_scene.add_child(temp_audio)
			temp_audio.play()
			temp_audio.finished.connect(temp_audio.queue_free)
		else:
			Stats.remove_score(amount)
			var temp_audio = audio_stream_player_bad.duplicate()
			get_tree().current_scene.add_child(temp_audio)
			temp_audio.play()
			temp_audio.finished.connect(temp_audio.queue_free)
		body.change_score_label()
		self.queue_free()
