extends Node

class_name PlayerStats

var level: int = 1
var experience: int = 0
var experience_to_level: int = 100

var vitality: int = 10
var strength: int = 10
var dexterity: int = 10
var endurance: int = 10
var luck: int = 5

signal level_changed(new_level: int)
signal stat_changed(stat_name: String, new_value: int)

func get_max_hp() -> int:
	return vitality * 5 + 25

func get_stamina() -> int:
	return endurance * 5 + 50

func get_attack_power() -> int:
	return strength * 3 + 10

func get_defense() -> int:
	return (vitality + strength) / 4 + 5

func get_crit_chance() -> float:
	return (dexterity + luck) * 0.01

func add_experience(amount: int) -> void:
	experience += amount
	while experience >= experience_to_level:
		level_up()

func level_up() -> void:
	experience -= experience_to_level
	level += 1
	experience_to_level = int(experience_to_level * 1.1)

	vitality += 1
	strength += 1
	dexterity += 1
	endurance += 1
	luck += 1

	level_changed.emit(level)

func add_stat_points(vitality_pts: int = 0, strength_pts: int = 0,
		dexterity_pts: int = 0, endurance_pts: int = 0, luck_pts: int = 0) -> void:
	if vitality_pts > 0:
		vitality += vitality_pts
		stat_changed.emit("vitality", vitality)
	if strength_pts > 0:
		strength += strength_pts
		stat_changed.emit("strength", strength)
	if dexterity_pts > 0:
		dexterity += dexterity_pts
		stat_changed.emit("dexterity", dexterity)
	if endurance_pts > 0:
		endurance += endurance_pts
		stat_changed.emit("endurance", endurance)
	if luck_pts > 0:
		luck += luck_pts
		stat_changed.emit("luck", luck)

func to_dict() -> Dictionary:
	return {
		"level": level,
		"experience": experience,
		"experience_to_level": experience_to_level,
		"vitality": vitality,
		"strength": strength,
		"dexterity": dexterity,
		"endurance": endurance,
		"luck": luck
	}

func from_dict(data: Dictionary) -> void:
	level = data.get("level", 1)
	experience = data.get("experience", 0)
	experience_to_level = data.get("experience_to_level", 100)
	vitality = data.get("vitality", 10)
	strength = data.get("strength", 10)
	dexterity = data.get("dexterity", 10)
	endurance = data.get("endurance", 10)
	luck = data.get("luck", 5)
