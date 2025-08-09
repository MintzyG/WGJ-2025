extends Node2D  # Or StaticBody2D if you need collisions

@export var point_a: Vector2
@export var point_b: Vector2
@export var speed: float = 100.0
@export var thing: Node2D  # The node to move
@export var is_end: bool = false
@onready var collider: Area2D = %Collider
@onready var collision_shape: CollisionShape2D = %CollisionShape

var target_position: Vector2
var direction: int = 1
var last_position: Vector2
var stopped: bool = false

func _ready():
	if not thing:
		push_error("No 'thing' assigned!")
		return

	thing.position = point_a
	target_position = point_b
	last_position = thing.position

	# Match collider size to thing's size
	_match_collider_to_thing()

	# Listen for collisions
	collider.body_entered.connect(_on_body_entered)

func _process(delta):
	if stopped or not thing:
		return

	var move_vector = (target_position - thing.position).normalized() * speed * delta
	if thing.position.distance_to(target_position) <= move_vector.length():
		thing.position = target_position
		direction *= -1
		target_position = point_b if direction == 1 else point_a
	else:
		thing.position += move_vector

	last_position = thing.position

func _on_body_entered(body: Node):
	if is_end and body.is_in_group("Player"):
		stopped = true

func _match_collider_to_thing():
	# Tries to match collision shape to thing’s visual bounds
	if collision_shape.shape is RectangleShape2D:
		var rect_size: Vector2
		if thing is Sprite2D:
			rect_size = thing.texture.get_size() * thing.scale
		elif thing is Node2D and thing.has_node("Sprite"):
			var sprite: Sprite2D = thing.get_node("Sprite")
			rect_size = sprite.texture.get_size() * sprite.scale
		else:
			return
		collision_shape.shape.size = rect_size
		collision_shape.position = Vector2.ZERO
