extends Enemy

class_name BossEnemy

enum PhaseState { PHASE_ONE, PHASE_TWO, PHASE_THREE }

@export var phase_one_health_threshold: float = 0.66
@export var phase_two_health_threshold: float = 0.33
@export var special_attack_cooldown: float = 3.0
@export var boss_experience_reward: int = 500
@export var boss_gold_reward: int = 100

var current_phase: PhaseState = PhaseState.PHASE_ONE
var special_attack_available: bool = true
var phase_changed: bool = false

func _ready() -> void:
	super()
	experience_reward = boss_experience_reward
	gold_reward = boss_gold_reward

func update_ai(delta: float) -> void:
	check_phase_change()
	match current_phase:
		PhaseState.PHASE_ONE:
			update_ai_phase_one(delta)
		PhaseState.PHASE_TWO:
			update_ai_phase_two(delta)
		PhaseState.PHASE_THREE:
			update_ai_phase_three(delta)

func check_phase_change() -> void:
	var health_percent = health / max_health
	var new_phase = current_phase

	if health_percent <= phase_two_health_threshold:
		new_phase = PhaseState.PHASE_THREE
	elif health_percent <= phase_one_health_threshold:
		new_phase = PhaseState.PHASE_TWO

	if new_phase != current_phase:
		current_phase = new_phase
		phase_changed = true
		on_phase_change()

func on_phase_change() -> void:
	attack_cooldown = max(0.5, attack_cooldown - 0.2)
	chase_speed += 20
	attack_damage += 5

func update_ai_phase_one(delta: float) -> void:
	super.update_ai(delta)

func update_ai_phase_two(delta: float) -> void:
	super.update_ai(delta)
	if special_attack_available and randf() < 0.02:
		perform_special_attack()

func update_ai_phase_three(delta: float) -> void:
	super.update_ai(delta)
	if special_attack_available and randf() < 0.05:
		perform_special_attack()
	chase_speed *= 1.1

func perform_special_attack() -> void:
	if not player:
		return

	current_state = State.ATTACK
	special_attack_available = false

	deal_special_attack()
	await get_tree().create_timer(special_attack_cooldown).timeout
	special_attack_available = true

func deal_special_attack() -> void:
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)
	if distance < attack_range * 3:
		var damage = player.get_damage_received(attack_damage * 1.5)
		player.take_damage(damage)
