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

	var sprite = Sprite2D.new()
	sprite.modulate = Color.GRAY
	sprite.scale = Vector2(200, 2.5)
	ground.add_child(sprite)

	ground.position = Vector2(640, 650)
	add_child(ground)

	var platform1 = StaticBody2D.new()
	var p1_shape = RectangleShape2D.new()
	p1_shape.size = Vector2(300, 20)
	var p1_collision = CollisionShape2D.new()
	p1_collision.shape = p1_shape
	platform1.add_child(p1_collision)

	var p1_sprite = Sprite2D.new()
	p1_sprite.modulate = Color.GRAY
	p1_sprite.scale = Vector2(15, 1)
	platform1.add_child(p1_sprite)

	platform1.position = Vector2(300, 500)
	add_child(platform1)

	var platform2 = StaticBody2D.new()
	var p2_shape = RectangleShape2D.new()
	p2_shape.size = Vector2(300, 20)
	var p2_collision = CollisionShape2D.new()
	p2_collision.shape = p2_shape
	platform2.add_child(p2_collision)

	var p2_sprite = Sprite2D.new()
	p2_sprite.modulate = Color.GRAY
	p2_sprite.scale = Vector2(15, 1)
	platform2.add_child(p2_sprite)

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

	var sprite = Sprite2D.new()
	sprite.modulate = Color.BLACK
	sprite.scale = Vector2(1, 2)
	sprite.offset = Vector2(0, -10)
	player.add_child(sprite)

	var anim = AnimationPlayer.new()
	player.add_child(anim)

	create_player_animations(anim)

func create_player_animations(anim_player: AnimationPlayer) -> void:
	var idle = Animation.new()
	idle.length = 0.5
	anim_player.add_animation("idle", idle)

	var run = Animation.new()
	run.length = 0.4
	anim_player.add_animation("run", run)

	var jump = Animation.new()
	jump.length = 0.5
	anim_player.add_animation("jump", jump)

	var attack_light = Animation.new()
	attack_light.length = 0.5
	anim_player.add_animation("attack_light", attack_light)

	var attack_heavy = Animation.new()
	attack_heavy.length = 0.8
	anim_player.add_animation("attack_heavy", attack_heavy)

	var dodge = Animation.new()
	dodge.length = 0.4
	anim_player.add_animation("dodge", dodge)

	var block = Animation.new()
	block.length = 0.3
	anim_player.add_animation("block", block)

	var die = Animation.new()
	die.length = 1.0
	anim_player.add_animation("die", die)

func create_enemies() -> void:
	spawn_enemy("Slime", Vector2(400, 550))
	spawn_enemy("Slime", Vector2(550, 550))
	spawn_enemy("Rat", Vector2(800, 450))
	spawn_enemy("Rat", Vector2(1100, 450))
	spawn_enemy("Goblin", Vector2(1300, 550))
	spawn_enemy("Goblin", Vector2(1500, 550))

func spawn_enemy(enemy_type: String, pos: Vector2) -> void:
	var enemy: Enemy = null
	match enemy_type:
		"Slime":
			enemy = Slime.new()
		"Rat":
			enemy = Rat.new()
		"Goblin":
			enemy = Goblin.new()

	if enemy:
		enemy.position = pos
		add_child(enemy)

		var collision = CollisionShape2D.new()
		var shape = CircleShape2D.new()
		shape.radius = 15
		collision.shape = shape
		enemy.add_child(collision)

		var sprite = Sprite2D.new()
		sprite.modulate = Color.RED
		sprite.scale = Vector2(1, 1.5)
		enemy.add_child(sprite)

		var anim = AnimationPlayer.new()
		enemy.add_child(anim)

		create_enemy_animations(anim)

func create_enemy_animations(anim_player: AnimationPlayer) -> void:
	var idle = Animation.new()
	idle.length = 0.5
	anim_player.add_animation("idle", idle)

	var walk = Animation.new()
	walk.length = 0.4
	anim_player.add_animation("walk", walk)

	var attack = Animation.new()
	attack.length = 0.5
	anim_player.add_animation("attack", attack)

	var hurt = Animation.new()
	hurt.length = 0.2
	anim_player.add_animation("hurt", hurt)

	var die = Animation.new()
	die.length = 1.0
	anim_player.add_animation("die", die)

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
