extends KinematicBody2D

signal state_change

var player_speed = 75

const dash_speed = 100 * 3
var dash_vec = Vector2(0, 0)
var isDashing = false
var isDashReady = true 
var dash_cd_timer = Timer.new()
var dash_timer = Timer.new()
const dash_cd = 2.5
const dash_duration = 0.15

var movement_vec = Vector2(0, 0)
var last_dir = "DOWN"

const UP_VEC = Vector2(0, -1)
const LEFT_VEC = Vector2(-1, 0)
const RIGHT_VEC = Vector2(1, 0)
const DOWN_VEC = Vector2(0, 1)

func _ready():
	get_node("P_AnimatedSprite").playing = true
	emit_signal("state_change", self)
	
	dash_cd_timer.set_wait_time(dash_cd)
	dash_cd_timer.set_one_shot(true)
	dash_cd_timer.connect("timeout", self, "set_isDashReady_true")
	add_child(dash_cd_timer)
	
	dash_timer.set_wait_time(dash_duration)
	dash_timer.set_one_shot(true)
	dash_timer.connect("timeout", self, "set_isDashing_false")
	add_child(dash_timer)

func set_idle_animation():
	if (last_dir == "UP"):
		get_node("P_AnimatedSprite").animation = "P_idleUp"
	elif (last_dir == "DOWN"):
		get_node("P_AnimatedSprite").animation = "P_idleDown"
	elif (last_dir == "RIGHT"):
		get_node("P_AnimatedSprite").animation = "P_idleRight"
	elif (last_dir == "LEFT"):
		get_node("P_AnimatedSprite").animation = "P_idleLeft"

func set_animation():
	if (movement_vec == Vector2(-1, -1)):
		get_node("P_AnimatedSprite").animation = "P_walkUp"
	elif (movement_vec == Vector2(0, -1)):
		get_node("P_AnimatedSprite").animation = "P_walkUp"
	elif (movement_vec == Vector2(-1, 0)):
		get_node("P_AnimatedSprite").animation = "P_walkLeft"
	elif (movement_vec == Vector2(0, 0)):
		set_idle_animation()
	elif (movement_vec == Vector2(0, 1)):
		get_node("P_AnimatedSprite").animation = "P_walkDown"
	elif (movement_vec == Vector2(1, 0)):
		get_node("P_AnimatedSprite").animation = "P_walkRight"
	elif (movement_vec == Vector2(1, 1)):
		get_node("P_AnimatedSprite").animation = "P_walkDown"

func _input(event):
	if (event.is_action_type()):
		# Movment
		movement_vec = Vector2(0, 0)
		if Input.is_action_pressed("ui_up"):
			movement_vec += UP_VEC
		if Input.is_action_pressed("ui_down"):
			movement_vec += DOWN_VEC
		if Input.is_action_pressed("ui_left"):
			movement_vec += LEFT_VEC
		if Input.is_action_pressed("ui_right"):
			movement_vec += RIGHT_VEC
		
		# Animation
		if Input.is_action_just_released("ui_up"):
			last_dir = "UP"
		elif Input.is_action_just_released("ui_down"):
			last_dir = "DOWN"
		elif Input.is_action_just_released("ui_left"):
			last_dir = "LEFT"
		elif Input.is_action_just_released("ui_right"):
			last_dir = "RIGHT"
		set_animation()
	
	# Skill
	if Input.is_key_pressed(KEY_SPACE):
		trigger_dash()

func trigger_dash():
	if (isDashReady && movement_vec.length() > 0):
		isDashReady = false
		isDashing = true
		dash_vec = movement_vec
		dash_cd_timer.start()
		dash_timer.start()

func set_isDashReady_true():
	isDashReady = true

func set_isDashing_false():
	isDashing = false

func process_dash(delta):
	if (isDashing):
		var collision = move_and_collide(delta * dash_speed * dash_vec.normalized())

func _process(delta):
	process_dash(delta)
	var collision = move_and_collide(delta * player_speed * movement_vec.normalized())
