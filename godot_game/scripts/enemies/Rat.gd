extends Enemy

func _ready() -> void:
	health = 20.0
	max_health = health
	attack_damage = 4.0
	attack_range = 30.0
	chase_range = 200.0
	patrol_speed = 60.0
	chase_speed = 130.0
	experience_reward = 8
	gold_reward = 3
	super()
