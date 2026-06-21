extends Node

class_name DifficultyScaler

var base_difficulty: float = 1.0
var current_zone: int = 1
var enemy_health_multiplier: float = 1.0
var enemy_damage_multiplier: float = 1.0
var loot_multiplier: float = 1.0
var xp_multiplier: float = 1.0

func _ready() -> void:
	calculate_difficulty()

func set_zone(zone: int) -> void:
	current_zone = clamp(zone, 1, 10)
	calculate_difficulty()

func calculate_difficulty() -> void:
	var difficulty = GameSettings.get_difficulty_multiplier()
	var zone_scaling = 1.0 + (current_zone - 1) * 0.15

	base_difficulty = difficulty * zone_scaling

	enemy_health_multiplier = base_difficulty * 0.8
	enemy_damage_multiplier = base_difficulty * 1.2
	loot_multiplier = base_difficulty * 0.9
	xp_multiplier = base_difficulty * 1.1

func scale_enemy_health(base_health: float) -> float:
	return base_health * enemy_health_multiplier

func scale_enemy_damage(base_damage: float) -> float:
	return base_damage * enemy_damage_multiplier

func scale_loot_amount(base_amount: int) -> int:
	return int(base_amount * loot_multiplier)

func scale_experience(base_xp: int) -> int:
	return int(base_xp * xp_multiplier)

func get_zone_difficulty_rating() -> String:
	match current_zone:
		1, 2:
			return "Easy"
		3, 4:
			return "Normal"
		5, 6:
			return "Hard"
		7, 8:
			return "Very Hard"
		9, 10:
			return "Extreme"
	return "Unknown"

func get_difficulty_name() -> String:
	var difficulty = GameSettings.get_setting("difficulty", GameSettings.DIFFICULTY_NORMAL)
	match difficulty:
		GameSettings.DIFFICULTY_EASY:
			return "Easy"
		GameSettings.DIFFICULTY_NORMAL:
			return "Normal"
		GameSettings.DIFFICULTY_HARD:
			return "Hard"
		GameSettings.DIFFICULTY_CHALLENGE:
			return "Challenge"
	return "Normal"
