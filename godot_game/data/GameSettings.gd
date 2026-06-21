extends Node

class_name GameSettings

const DIFFICULTY_EASY = 0
const DIFFICULTY_NORMAL = 1
const DIFFICULTY_HARD = 2
const DIFFICULTY_CHALLENGE = 3

static var settings = {
	"difficulty": DIFFICULTY_NORMAL,
	"master_volume": 1.0,
	"music_volume": 1.0,
	"sfx_volume": 1.0,
	"enable_vsync": true,
	"target_fps": 60,
	"enable_particles": true,
	"enable_bloom": true,
	"controller_enabled": true,
	"keyboard_enabled": true,
	"controller_vibration": true,
	"ui_scale": 1.0,
	"camera_smoothing": 0.1,
	"difficulty_multiplier": 1.0,
}

static func get_setting(key: String, default_value = null):
	return settings.get(key, default_value)

static func set_setting(key: String, value) -> void:
	settings[key] = value

static func get_difficulty_multiplier() -> float:
	match settings["difficulty"]:
		DIFFICULTY_EASY:
			return 0.75
		DIFFICULTY_NORMAL:
			return 1.0
		DIFFICULTY_HARD:
			return 1.25
		DIFFICULTY_CHALLENGE:
			return 1.5
	return 1.0

static func save_settings() -> void:
	var config = ConfigFile.new()
	for key in settings:
		config.set_value("settings", key, settings[key])
	config.save("user://game_settings.cfg")

static func load_settings() -> void:
	var config = ConfigFile.new()
	var error = config.load("user://game_settings.cfg")
	if error == OK:
		for key in settings.keys():
			var value = config.get_value("settings", key, null)
			if value != null:
				settings[key] = value
