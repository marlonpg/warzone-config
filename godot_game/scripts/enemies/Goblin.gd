extends Enemy

func _ready() -> void:
	health = 25.0
	max_health = health
	attack_damage = 5.0
	attack_range = 35.0
	chase_range = 220.0
	patrol_speed = 55.0
	chase_speed = 110.0
	experience_reward = 12
	gold_reward = 5
	super()
