extends Node

var player_score: int = 0

func _reset_score():
	player_score = 0

func add_score(amount: int):
	player_score += amount
	
func remove_score(amount: int):
	player_score -= amount
