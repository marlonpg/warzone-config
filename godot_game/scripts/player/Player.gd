extends CharacterBody2D

class_name Player

signal health_changed(new_health: float)

const GRAVITY = 980.0
const JUMP_FORCE = -400.0
const MOVE_SPEED = 150.0
const SPRINT_MULTIPLIER = 1.5
const DODGE_DISTANCE = 200.0
const DODGE_DURATION = 0.4
const LIGHT_ATTACK_DURATION = 0.5
const HEAVY_ATTACK_DURATION = 0.8
const PARRY_WINDOW = 0.2

enum State { IDLE, RUNNING, JUMPING, ATTACKING, HEAVY_ATTACKING, BLOCKING, DODGING, PARRYING, DYING }

var anim_player: AnimationPlayer
var sprite: Sprite2D
var collision_shape: CollisionShape2D

var current_state: State = State.IDLE
var previous_state: State = State.IDLE

var health: float
var max_health: float
var stamina: float
var max_stamina: float
var stamina_regen: float = 15.0

var facing_right: bool = true
var is_falling: bool = false
var is_dodging: bool = false
var dodge_direction: float = 0.0

var input_manager: InputManager
var game_manager: GameManager
var player_stats: PlayerStats

var dropped_gold_scene = preload("res://scenes/world/DroppedGold.tscn")
var current_gold_dropped: Node2D = null

func _ready() -> void:
	anim_player = get_node_or_null("AnimationPlayer")
	sprite = get_node_or_null("Sprite2D")
	collision_shape = get_node_or_null("CollisionShape2D")

	input_manager = get_tree().get_first_node_in_group("input_manager")
	game_manager = get_tree().get_first_node_in_group("game_manager")
	player_stats = game_manager.player_stats

	max_health = player_stats.get_max_hp()
	health = max_health
	max_stamina = player_stats.get_stamina()
	stamina = max_stamina

	if input_manager:
		input_manager.light_attack.connect(_on_light_attack)
		input_manager.heavy_attack.connect(_on_heavy_attack)
		input_manager.dodge.connect(_on_dodge)
		input_manager.block.connect(_on_block)
		input_manager.jump.connect(_on_jump)

	game_manager.set_player(self)
	add_to_group("player")

func _physics_process(delta: float) -> void:
	if current_state == State.DYING:
		return

	apply_gravity(delta)
	handle_input(delta)
	update_state(delta)
	update_animation()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		is_falling = true
	else:
		is_falling = false

func handle_input(delta: float) -> void:
	if current_state in [State.ATTACKING, State.HEAVY_ATTACKING, State.DODGING]:
		return

	if not input_manager:
		return

	var move_input = input_manager.get_movement_input()
	var is_blocking = input_manager.is_blocking()
	var is_sprinting = input_manager.is_sprinting()

	if move_input != 0:
		if move_input > 0:
			facing_right = true
		elif move_input < 0:
			facing_right = false
		var speed = MOVE_SPEED
		if is_sprinting and stamina > 0:
			speed *= SPRINT_MULTIPLIER
			stamina -= 5.0 * delta
		velocity.x = move_input * speed
		if current_state != State.JUMPING:
			current_state = State.RUNNING
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 5.0)
		if current_state not in [State.JUMPING, State.BLOCKING]:
			current_state = State.IDLE

	if is_blocking and stamina > 0:
		current_state = State.BLOCKING
		stamina -= 2.0 * delta
	elif current_state == State.BLOCKING:
		current_state = State.IDLE

	stamina = clamp(stamina + stamina_regen * delta, 0, max_stamina)

func update_state(delta: float) -> void:
	match current_state:
		State.JUMPING:
			if is_on_floor() and velocity.y >= 0:
				current_state = State.IDLE
		State.DODGING:
			velocity.x = dodge_direction
		State.ATTACKING:
			velocity.x = 0
		State.HEAVY_ATTACKING:
			velocity.x = 0
		State.BLOCKING:
			velocity.x = 0

func update_animation() -> void:
	if sprite:
		sprite.flip_h = not facing_right

	if not anim_player:
		return

	match current_state:
		State.IDLE:
			anim_player.play("idle")
		State.RUNNING:
			anim_player.play("run")
		State.JUMPING:
			anim_player.play("jump")
		State.ATTACKING:
			anim_player.play("attack_light")
		State.HEAVY_ATTACKING:
			anim_player.play("attack_heavy")
		State.BLOCKING:
			anim_player.play("block")
		State.DODGING:
			anim_player.play("dodge")

func take_damage(damage: float) -> void:
	health -= damage
	health_changed.emit(health)
	if health <= 0:
		die()

func heal(amount: float) -> void:
	health = clamp(health + amount, 0, max_health)

func die() -> void:
	current_state = State.DYING
	anim_player.play("die")
	if game_manager.current_gold > 0:
		var gold_drop = dropped_gold_scene.instantiate()
		gold_drop.position = global_position
		gold_drop.amount = game_manager.current_gold
		get_parent().add_child(gold_drop)
		current_gold_dropped = gold_drop
		game_manager.current_gold = 0

	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func _on_light_attack() -> void:
	if current_state in [State.ATTACKING, State.HEAVY_ATTACKING, State.DODGING, State.DYING]:
		return
	if stamina < 10:
		return

	stamina -= 10
	current_state = State.ATTACKING
	var damage = player_stats.get_attack_power()

	var attack_area = Area2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 30
	attack_area.add_child(shape)
	attack_area.position = global_position + (Vector2.RIGHT if facing_right else Vector2.LEFT) * 40
	get_parent().add_child(attack_area)

	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("enemies") and body.has_method("take_damage"):
			body.take_damage(damage)

	attack_area.queue_free()
	await get_tree().create_timer(LIGHT_ATTACK_DURATION).timeout
	if current_state == State.ATTACKING:
		current_state = State.IDLE

func _on_heavy_attack() -> void:
	if current_state in [State.ATTACKING, State.HEAVY_ATTACKING, State.DODGING, State.DYING]:
		return
	if stamina < 25:
		return

	stamina -= 25
	current_state = State.HEAVY_ATTACKING
	var damage = int(player_stats.get_attack_power() * 1.5)

	var attack_area = Area2D.new()
	var shape = CircleShape2D.new()
	shape.radius = 50
	attack_area.add_child(shape)
	attack_area.position = global_position + (Vector2.RIGHT if facing_right else Vector2.LEFT) * 50
	get_parent().add_child(attack_area)

	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("enemies") and body.has_method("take_damage"):
			body.take_damage(damage)

	attack_area.queue_free()
	await get_tree().create_timer(HEAVY_ATTACK_DURATION).timeout
	if current_state == State.HEAVY_ATTACKING:
		current_state = State.IDLE

func _on_dodge() -> void:
	if current_state in [State.DODGING, State.DYING]:
		return
	if stamina < 15:
		return

	stamina -= 15
	current_state = State.DODGING
	is_dodging = true
	dodge_direction = DODGE_DISTANCE * (1.0 if facing_right else -1.0) / DODGE_DURATION

	await get_tree().create_timer(DODGE_DURATION).timeout
	is_dodging = false
	if current_state == State.DODGING:
		current_state = State.IDLE

func _on_block() -> void:
	pass

func _on_jump() -> void:
	if not is_on_floor():
		return
	if current_state == State.DYING:
		return

	velocity.y = JUMP_FORCE
	current_state = State.JUMPING

func get_damage_received(base_damage: float) -> float:
	var defense = player_stats.get_defense()
	var reduction = defense * 0.01
	return base_damage * (1.0 - min(reduction, 0.75))
