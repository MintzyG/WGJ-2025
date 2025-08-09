extends Node2D  # or StaticBody2D if you want physics collisions

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0

var target_position: Vector2
var direction: int = 1  # 1 = going to B, -1 = going to A
var last_position: Vector2
var players_on_platform = []

func _ready():
	%PlayerDetector.body_entered.connect(_on_body_entered)
	%PlayerDetector.body_exited.connect(_on_body_exited)
	position = point_a
	target_position = point_b
	last_position = position

func _process(delta):
	var move_vector = (target_position - position).normalized() * speed * delta
	if position.distance_to(target_position) <= move_vector.length():
		position = target_position
		direction *= -1
		target_position = point_b if direction == 1 else point_a
	else:
		position += move_vector

	var platform_delta = position - last_position
	for player in players_on_platform:
		if player and player.is_inside_tree():
			player.global_position += platform_delta
	last_position = position

func _on_body_entered(body):
	if body is Player:
		players_on_platform.append(body)

func _on_body_exited(body):
	if body is Player:
		players_on_platform.erase(body)
