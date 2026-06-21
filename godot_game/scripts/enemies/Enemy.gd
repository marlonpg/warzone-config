extends CharacterBody2D

class_name Enemy

const GRAVITY = 980.0

enum State { IDLE, PATROL, CHASE, ATTACK, HURT, DYING }

@export var health: float = 30.0
@export var attack_damage: float = 5.0
@export var attack_range: float = 30.0
@export var attack_cooldown: float = 1.5
@export var chase_range: float = 200.0
@export var patrol_speed: float = 50.0
@export var chase_speed: float = 120.0
@export var experience_reward: int = 10
@export var gold_reward: int = 5

var sprite: Sprite2D
var anim_player: AnimationPlayer

var max_health: float
var current_state: State = State.IDLE
var facing_right: bool = true
var player: Player = null
var can_attack: bool = true
var patrol_direction: float = 1.0

func _ready() -> void:
	sprite = get_node_or_null("Sprite2D")
	anim_player = get_node_or_null("AnimationPlayer")
	max_health = health
	add_to_group("enemies")
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if current_state == State.DYING:
		return

	apply_gravity(delta)
	update_ai(delta)
	update_animation()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	elif velocity.y > 0:
		velocity.y = 0

func update_ai(delta: float) -> void:
	if not player:
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	match current_state:
		State.IDLE:
			velocity.x = 0
			if distance_to_player < chase_range:
				current_state = State.CHASE
			elif randf() < 0.02:
				current_state = State.PATROL

		State.PATROL:
			velocity.x = patrol_speed * patrol_direction
			if distance_to_player < chase_range:
				current_state = State.CHASE
			elif randf() < 0.01:
				patrol_direction *= -1.0
				current_state = State.IDLE

		State.CHASE:
			var direction = sign(player.global_position.x - global_position.x)
			velocity.x = direction * chase_speed
			facing_right = direction > 0

			if distance_to_player < attack_range and can_attack:
				current_state = State.ATTACK
			elif distance_to_player > chase_range * 1.5:
				current_state = State.IDLE

		State.ATTACK:
			velocity.x = 0
			if can_attack:
				deal_attack()
				can_attack = false
				await get_tree().create_timer(attack_cooldown).timeout
				can_attack = true
				if current_state == State.ATTACK:
					current_state = State.CHASE

func update_animation() -> void:
	if sprite:
		sprite.flip_h = not facing_right

	if not anim_player:
		return

	match current_state:
		State.IDLE:
			anim_player.play("idle")
		State.PATROL:
			anim_player.play("walk")
		State.CHASE:
			anim_player.play("walk")
		State.ATTACK:
			anim_player.play("attack")
		State.HURT:
			anim_player.play("hurt")

func take_damage(damage: float) -> void:
	health -= damage
	current_state = State.HURT

	if health <= 0:
		die()
	else:
		await get_tree().create_timer(0.3).timeout
		if current_state == State.HURT:
			current_state = State.CHASE if player else State.IDLE

func die() -> void:
	current_state = State.DYING
	anim_player.play("die")

	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if game_manager:
		game_manager.add_gold(gold_reward)
		if player:
			player.player_stats.add_experience(experience_reward)

	await get_tree().create_timer(1.0).timeout
	queue_free()

func deal_attack() -> void:
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)
	if distance < attack_range * 2:
		var damage = player.get_damage_received(attack_damage)
		player.take_damage(damage)

func get_patrol_direction() -> void:
	patrol_direction = 1.0 if randf() > 0.5 else -1.0
