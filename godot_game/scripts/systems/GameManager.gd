extends Node

class_name GameManager

signal player_died
signal gold_changed(amount: int)
signal player_leveled_up(level: int)

var player_stats: PlayerStats
var current_gold: int = 0
var player: Node2D = null
var game_paused: bool = false

func _ready() -> void:
	player_stats = PlayerStats.new()
	add_child(player_stats)
	load_game()

func add_gold(amount: int) -> void:
	current_gold += amount
	gold_changed.emit(current_gold)

func spend_gold(amount: int) -> bool:
	if current_gold >= amount:
		current_gold -= amount
		gold_changed.emit(current_gold)
		return true
	return false

func set_player(new_player: Node2D) -> void:
	player = new_player

func toggle_pause() -> void:
	game_paused = !game_paused
	get_tree().paused = game_paused

func save_game() -> void:
	var save_data = {
		"gold": current_gold,
		"player_stats": player_stats.to_dict()
	}
	var save_file = FileAccess.open("user://tower_of_souls.save", FileAccess.WRITE)
	if save_file:
		save_file.store_var(save_data)

func load_game() -> void:
	if ResourceLoader.exists("user://tower_of_souls.save"):
		var save_file = FileAccess.open("user://tower_of_souls.save", FileAccess.READ)
		if save_file:
			var save_data = save_file.get_var()
			current_gold = save_data.get("gold", 0)
			player_stats.from_dict(save_data.get("player_stats", {}))
			gold_changed.emit(current_gold)

func respawn_player() -> void:
	if player:
		player.die()
		player_died.emit()
