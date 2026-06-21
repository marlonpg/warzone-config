extends CanvasLayer

class_name HUD

@onready var health_bar = $VBoxContainer/HealthBar
@onready var stamina_bar = $VBoxContainer/StaminaBar
@onready var level_label = $VBoxContainer/LevelLabel
@onready var gold_label = $VBoxContainer/GoldLabel
@onready var exp_label = $VBoxContainer/ExpLabel

var player: Player
var player_stats: PlayerStats
var game_manager: GameManager

func _ready() -> void:
	game_manager = get_tree().get_first_node_in_group("game_manager")
	player_stats = game_manager.player_stats

	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

	if player:
		player.health_changed.connect(_on_player_health_changed)

	game_manager.gold_changed.connect(_on_gold_changed)
	player_stats.level_changed.connect(_on_level_changed)

	update_ui()

func _process(_delta: float) -> void:
	if player:
		update_health_bar()
		update_stamina_bar()
		update_exp()

func update_ui() -> void:
	update_health_bar()
	update_stamina_bar()
	_on_level_changed(player_stats.level)
	_on_gold_changed(game_manager.current_gold)

func update_health_bar() -> void:
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.health

func update_stamina_bar() -> void:
	if player:
		stamina_bar.max_value = player.max_stamina
		stamina_bar.value = player.stamina

func update_exp() -> void:
	var progress = float(player_stats.experience) / player_stats.experience_to_level
	exp_label.text = "EXP: %d/%d (%.1f%%)" % [player_stats.experience, player_stats.experience_to_level, progress * 100]

func _on_player_health_changed(new_health: float) -> void:
	health_bar.value = new_health

func _on_gold_changed(amount: int) -> void:
	gold_label.text = "Gold: %d" % amount

func _on_level_changed(new_level: int) -> void:
	level_label.text = "Level: %d" % new_level
