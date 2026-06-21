extends Node

class_name ContentManager

const LOOT_TABLE = {
	"slime": {
		"items": ["slime_core"],
		"weights": [0.5],
		"gold_range": [1, 3]
	},
	"rat": {
		"items": ["rat_tail", "rat_tooth"],
		"weights": [0.4, 0.3],
		"gold_range": [2, 5]
	},
	"goblin": {
		"items": ["goblin_dagger", "goblin_armor"],
		"weights": [0.6, 0.2],
		"gold_range": [5, 15]
	},
	"goblin_king": {
		"items": ["royal_crown", "greatsword"],
		"weights": [1.0, 0.8],
		"gold_range": [100, 200]
	}
}

const ZONE_DATA = {
	"ruins_entrance": {
		"name": "Ruined Entrance",
		"floors": [1, 10],
		"enemies": ["slime", "rat", "goblin"],
		"boss": "goblin_king",
		"difficulty": 1.0,
		"theme": "ancient_ruins"
	},
	"goblin_quarters": {
		"name": "Goblin Quarters",
		"floors": [11, 20],
		"enemies": ["goblin", "goblin_archer", "goblin_warrior"],
		"boss": "goblin_warlord",
		"difficulty": 1.5,
		"theme": "goblin_settlement"
	},
	"forgotten_crypt": {
		"name": "Forgotten Crypt",
		"floors": [21, 30],
		"enemies": ["skeleton", "undead_warrior", "necromancer"],
		"boss": "bone_colossus",
		"difficulty": 2.0,
		"theme": "dark_crypt"
	}
}

const NPC_DATA = {
	"merchant": {
		"name": "Merchant",
		"dialogue": "Welcome traveler! Buy or sell goods here.",
		"location": "hub"
	},
	"blacksmith": {
		"name": "Blacksmith",
		"dialogue": "Need to upgrade your equipment?",
		"location": "hub"
	},
	"sage": {
		"name": "Sage",
		"dialogue": "Seek knowledge in the library within.",
		"location": "hub"
	}
}

static func get_loot_for_enemy(enemy_type: String) -> Dictionary:
	return LOOT_TABLE.get(enemy_type, {})

static func get_zone_data(zone_key: String) -> Dictionary:
	return ZONE_DATA.get(zone_key, {})

static func get_npc_data(npc_key: String) -> Dictionary:
	return NPC_DATA.get(npc_key, {})

static func roll_loot(enemy_type: String) -> String:
	var loot_data = LOOT_TABLE.get(enemy_type, {})
	if loot_data.is_empty():
		return ""

	var items = loot_data.get("items", [])
	var weights = loot_data.get("weights", [])

	if items.is_empty():
		return ""

	var random_value = randf()
	var cumulative_weight = 0.0

	for i in range(items.size()):
		cumulative_weight += weights[i] if i < weights.size() else 0.1
		if random_value <= cumulative_weight:
			return items[i]

	return ""

static func get_gold_reward(enemy_type: String) -> int:
	var loot_data = LOOT_TABLE.get(enemy_type, {})
	var gold_range = loot_data.get("gold_range", [0, 5])
	return randi_range(gold_range[0], gold_range[1])
