extends Node2D

class_name MainScene

var game_manager: GameManager
var input_manager: InputManager
var player: Player
var camera: Camera2D

func _ready() -> void:
	create_managers()
	setup_level()

func create_managers() -> void:
	game_manager = GameManager.new()
	game_manager.add_to_group("game_manager")
	add_child(game_manager)

	input_manager = InputManager.new()
	input_manager.add_to_group("input_manager")
	add_child(input_manager)

func setup_level() -> void:
	create_ground()
	create_player()
	create_enemies()
	create_hud()
	setup_camera()

func create_ground() -> void:
	var ground = StaticBody2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(4000, 50)

	var collision = CollisionShape2D.new()
	collision.shape = shape
	ground.add_child(collision)

	var rect = ColorRect.new()
	rect.color = Color.GRAY
	rect.size = Vector2(4000, 50)
	rect.position = Vector2(-2000, -25)
	ground.add_child(rect)

	ground.position = Vector2(640, 650)
	add_child(ground)

	var platform1 = StaticBody2D.new()
	var p1_shape = RectangleShape2D.new()
	p1_shape.size = Vector2(300, 20)
	var p1_collision = CollisionShape2D.new()
	p1_collision.shape = p1_shape
	platform1.add_child(p1_collision)

	var p1_rect = ColorRect.new()
	p1_rect.color = Color.GRAY
	p1_rect.size = Vector2(300, 20)
	p1_rect.position = Vector2(-150, -10)
	platform1.add_child(p1_rect)

	platform1.position = Vector2(300, 500)
	add_child(platform1)

	var platform2 = StaticBody2D.new()
	var p2_shape = RectangleShape2D.new()
	p2_shape.size = Vector2(300, 20)
	var p2_collision = CollisionShape2D.new()
	p2_collision.shape = p2_shape
	platform2.add_child(p2_collision)

	var p2_rect = ColorRect.new()
	p2_rect.color = Color.GRAY
	p2_rect.size = Vector2(300, 20)
	p2_rect.position = Vector2(-150, -10)
	platform2.add_child(p2_rect)

	platform2.position = Vector2(950, 400)
	add_child(platform2)

func create_player() -> void:
	player = Player.new()
	player.position = Vector2(640, 500)
	add_child(player)

	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.size = Vector2(20, 40)
	collision.shape = shape
	collision.position = Vector2(0, -10)
	player.add_child(collision)

	var rect = ColorRect.new()
	rect.color = Color.BLACK
	rect.size = Vector2(20, 40)
	rect.position = Vector2(-10, -20)
	player.add_child(rect)

	var anim = AnimationPlayer.new()
	player.add_child(anim)

	create_player_animations(anim)

func create_player_animations(anim_player: AnimationPlayer) -> void:
	# Animation creation is simplified for now
	# In Godot 4.5, animations are typically created in the editor
	# This is a placeholder that can be expanded with real animations
	pass

func create_enemies() -> void:
	spawn_enemy("Slime", Vector2(400, 550))
	spawn_enemy("Slime", Vector2(550, 550))
	spawn_enemy("Rat", Vector2(800, 450))
	spawn_enemy("Rat", Vector2(1100, 450))
	spawn_enemy("Goblin", Vector2(1300, 550))
	spawn_enemy("Goblin", Vector2(1500, 550))

func spawn_enemy(enemy_type: String, pos: Vector2) -> void:
	var enemy: Enemy = Enemy.new()

	match enemy_type:
		"Slime":
			enemy.health = 15.0
			enemy.attack_damage = 3.0
			enemy.experience_reward = 5
			enemy.gold_reward = 2
		"Rat":
			enemy.health = 20.0
			enemy.attack_damage = 4.0
			enemy.experience_reward = 8
			enemy.gold_reward = 3
		"Goblin":
			enemy.health = 25.0
			enemy.attack_damage = 5.0
			enemy.experience_reward = 12
			enemy.gold_reward = 5

	if enemy:
		enemy.position = pos
		add_child(enemy)

		await get_tree().process_frame

		var collision = CollisionShape2D.new()
		var shape = CircleShape2D.new()
		shape.radius = 15
		collision.shape = shape
		enemy.add_child(collision)

		var rect = ColorRect.new()
		rect.color = Color.RED
		rect.size = Vector2(30, 30)
		rect.position = Vector2(-15, -15)
		enemy.add_child(rect)

		var anim = AnimationPlayer.new()
		enemy.add_child(anim)

		create_enemy_animations(anim)

func create_enemy_animations(anim_player: AnimationPlayer) -> void:
	# Animation creation is simplified for now
	# In Godot 4.5, animations are typically created in the editor
	# This is a placeholder that can be expanded with real animations
	pass

func create_hud() -> void:
	var hud_layer = CanvasLayer.new()
	hud_layer.layer = 100

	var vbox = VBoxContainer.new()
	vbox.anchor_left = 0.0
	vbox.anchor_top = 0.0
	vbox.offset_right = 300
	vbox.offset_bottom = 150

	var level_label = Label.new()
	level_label.text = "Level: 1"
	level_label.add_theme_color_override("font_color", Color.WHITE)
	vbox.add_child(level_label)

	var health_bar = ProgressBar.new()
	health_bar.custom_minimum_size = Vector2(200, 20)
	health_bar.max_value = 100
	health_bar.value = 100
	health_bar.modulate = Color.GREEN
	vbox.add_child(health_bar)

	var stamina_bar = ProgressBar.new()
	stamina_bar.custom_minimum_size = Vector2(200, 20)
	stamina_bar.max_value = 100
	stamina_bar.value = 100
	stamina_bar.modulate = Color.CYAN
	vbox.add_child(stamina_bar)

	var gold_label = Label.new()
	gold_label.text = "Gold: 0"
	gold_label.add_theme_color_override("font_color", Color.YELLOW)
	vbox.add_child(gold_label)

	var exp_label = Label.new()
	exp_label.text = "EXP: 0/100"
	exp_label.add_theme_color_override("font_color", Color.WHITE)
	vbox.add_child(exp_label)

	hud_layer.add_child(vbox)
	add_child(hud_layer)

func setup_camera() -> void:
	camera = Camera2D.new()
	camera.enabled = true
	camera.global_position = player.global_position
	add_child(camera)

func _process(_delta: float) -> void:
	if player and camera:
		camera.global_position = camera.global_position.lerp(player.global_position, 0.1)
		camera.global_position.y = clamp(camera.global_position.y, 360, 10000)
