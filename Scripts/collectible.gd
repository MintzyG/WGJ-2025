extends Area2D
class_name Collectible

@export var is_star: bool = true
@export var amount: int = 1
@onready var sprite: Sprite2D = %Sprite

@export var star_sprite: Texture2D
@export var anti_matter_sprite: Texture2D

func _ready() -> void:
	if is_star:
		sprite.texture = star_sprite
	else:
		sprite.texture = anti_matter_sprite

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if is_star:
			Stats.add_score(amount)
		else:
			Stats.remove_score(amount)
		body.change_score_label()
		self.queue_free()
