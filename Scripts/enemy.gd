extends CharacterBody2D

@export var speed: float = 100.0
@export var damage: int = 1
@export var wall_check_distance: float = 4.0

var direction: int = -1  # -1 = esquerda, 1 = direita

func _physics_process(delta: float) -> void:
	# Movimento horizontal
	velocity.x = direction * speed

	# Checa colisão com paredes usando raycast manual
	var wall_check_position = Vector2(wall_check_distance * direction, 0)
	if is_on_wall() or test_move(transform, wall_check_position):
		direction *= -1  # inverte direção

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("take_damage"):
			body.take_damage(damage)
