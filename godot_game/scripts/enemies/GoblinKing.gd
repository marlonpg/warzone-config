extends BossEnemy

func _ready() -> void:
	health = 150.0
	max_health = health
	attack_damage = 12.0
	attack_range = 40.0
	chase_range = 300.0
	patrol_speed = 60.0
	chase_speed = 140.0
	experience_reward = 500
	gold_reward = 100
	phase_one_health_threshold = 0.66
	phase_two_health_threshold = 0.33
	special_attack_cooldown = 2.5
	super()
