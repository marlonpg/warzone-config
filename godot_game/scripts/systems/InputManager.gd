extends Node

class_name InputManager

const JOYSTICK_DEADZONE = 0.3

signal light_attack
signal heavy_attack
signal dodge
signal block
signal sprint_toggled(enabled: bool)
signal interact
signal jump

var is_controller_connected: bool = false
var current_joypad_device: int = 0
var sprinting: bool = false
var last_sprint_input: float = 0.0

func _ready() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	check_controller_connection()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_RIGHT, KEY_D:
					pass
				KEY_LEFT, KEY_A:
					pass
				KEY_UP, KEY_W:
					pass
				KEY_DOWN, KEY_S:
					pass
				KEY_SPACE:
					jump.emit()
				KEY_SHIFT:
					sprinting = !sprinting
					sprint_toggled.emit(sprinting)
				KEY_E:
					interact.emit()
				KEY_BRACKETRIGHT:
					light_attack.emit()
				KEY_BRACKETLEFT:
					heavy_attack.emit()
				KEY_CTRL:
					dodge.emit()
				KEY_CONTROL:
					block.emit()
	elif event is InputEventJoypadButton:
		if event.pressed:
			match event.button_index:
				JOY_BUTTON_A:
					jump.emit()
				JOY_BUTTON_B:
					dodge.emit()
				JOY_BUTTON_X:
					light_attack.emit()
				JOY_BUTTON_Y:
					heavy_attack.emit()
				JOY_BUTTON_LB:
					block.emit()
				JOY_BUTTON_RB:
					light_attack.emit()
				JOY_BUTTON_START:
					sprinting = !sprinting
					sprint_toggled.emit(sprinting)

func get_movement_input() -> float:
	var input = 0.0

	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		input += 1.0
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		input -= 1.0

	if is_controller_connected:
		var axis = Input.get_joy_axis(current_joypad_device, JOY_AXIS_LEFT_X)
		if abs(axis) > JOYSTICK_DEADZONE:
			input = axis

	return clamp(input, -1.0, 1.0)

func get_vertical_input() -> float:
	var input = 0.0

	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		input += 1.0
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		input -= 1.0

	if is_controller_connected:
		var axis = Input.get_joy_axis(current_joypad_device, JOY_AXIS_LEFT_Y)
		if abs(axis) > JOYSTICK_DEADZONE:
			input = axis

	return clamp(input, -1.0, 1.0)

func is_blocking() -> bool:
	return Input.is_key_pressed(KEY_SHIFT)

func is_sprinting() -> bool:
	return sprinting

func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		is_controller_connected = true
		current_joypad_device = device
		print("Controller connected: ", device)
	else:
		is_controller_connected = false
		print("Controller disconnected: ", device)

func check_controller_connection() -> void:
	var devices = Input.get_connected_joypads()
	if devices.size() > 0:
		is_controller_connected = true
		current_joypad_device = devices[0]
