extends Enemy

func _ready() -> void:
	health = 15.0
	max_health = health
	attack_damage = 3.0
	attack_range = 25.0
	chase_range = 150.0
	patrol_speed = 40.0
	chase_speed = 80.0
	experience_reward = 5
	gold_reward = 2
	super()
