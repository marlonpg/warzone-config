extends Node

class_name SaveManager

const SAVE_PATH = "user://tower_of_souls/"
const SAVE_FILE = "user://tower_of_souls/save_game.json"
const SLOT_COUNT = 3

var current_slot: int = 0
var save_data: Dictionary = {}

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_PATH):
		DirAccess.make_absolute(SAVE_PATH)

func save_game(slot: int = 0) -> bool:
	current_slot = slot
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if not game_manager:
		return false

	save_data = {
		"slot": slot,
		"timestamp": Time.get_ticks_msec(),
		"player_position": Vector2.ZERO,
		"gold": game_manager.current_gold,
		"player_stats": game_manager.player_stats.to_dict(),
		"game_settings": GameSettings.settings
	}

	if game_manager.player:
		save_data["player_position"] = game_manager.player.global_position

	var json_string = JSON.stringify(save_data)
	var save_file = FileAccess.open(SAVE_FILE.format({"slot": slot}), FileAccess.WRITE)
	if save_file:
		save_file.store_string(json_string)
		return true

	return false

func load_game(slot: int = 0) -> bool:
	current_slot = slot
	var save_file_path = SAVE_FILE.format({"slot": slot})

	if not ResourceLoader.exists(save_file_path):
		return false

	var save_file = FileAccess.open(save_file_path, FileAccess.READ)
	if not save_file:
		return false

	var json_string = save_file.get_as_text()
	var json = JSON.new()
	if json.parse(json_string) != OK:
		return false

	save_data = json.data
	return true

func get_save_data() -> Dictionary:
	return save_data.duplicate(true)

func get_save_slots() -> Array:
	var slots = []
	for i in range(SLOT_COUNT):
		var file_path = SAVE_FILE.format({"slot": i})
		var file_info = {
			"slot": i,
			"exists": ResourceLoader.exists(file_path),
			"timestamp": 0,
			"player_level": 1,
			"gold": 0
		}

		if file_info["exists"]:
			var save_file = FileAccess.open(file_path, FileAccess.READ)
			if save_file:
				var json = JSON.new()
				if json.parse(save_file.get_as_text()) == OK:
					var data = json.data
					file_info["timestamp"] = data.get("timestamp", 0)
					file_info["player_level"] = data.get("player_stats", {}).get("level", 1)
					file_info["gold"] = data.get("gold", 0)

		slots.append(file_info)

	return slots

func delete_save(slot: int) -> bool:
	var file_path = SAVE_FILE.format({"slot": slot})
	if ResourceLoader.exists(file_path):
		var dir = DirAccess.open(SAVE_PATH)
		if dir:
			return dir.remove(file_path) == OK
	return false

func apply_save_to_game() -> void:
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if not game_manager:
		return

	game_manager.current_gold = save_data.get("gold", 0)
	game_manager.player_stats.from_dict(save_data.get("player_stats", {}))

	if game_manager.player:
		game_manager.player.global_position = save_data.get("player_position", Vector2.ZERO)

	if "game_settings" in save_data:
		GameSettings.settings = save_data["game_settings"]
