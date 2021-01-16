extends Node2D

var player_speed = 50
var movement_vec = Vector2(0, 0)
var last_dir = "DOWN"

const UP_VEC = Vector2(0, -1)
const LEFT_VEC = Vector2(-1, 0)
const RIGHT_VEC = Vector2(1, 0)
const DOWN_VEC = Vector2(0, 1)

func _ready():
	get_node("P_AnimatedSprite").playing = true
	print("Player node _ready")

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
		movement_vec = Vector2(0, 0)
		if Input.is_action_pressed("ui_up"):
			movement_vec += UP_VEC
		if Input.is_action_pressed("ui_down"):
			movement_vec += DOWN_VEC
		if Input.is_action_pressed("ui_left"):
			movement_vec += LEFT_VEC
		if Input.is_action_pressed("ui_right"):
			movement_vec += RIGHT_VEC
	
		if Input.is_action_just_released("ui_up"):
			last_dir = "UP"
		elif Input.is_action_just_released("ui_down"):
			last_dir = "DOWN"
		elif Input.is_action_just_released("ui_left"):
			last_dir = "LEFT"
		elif Input.is_action_just_released("ui_right"):
			last_dir = "RIGHT"
		
		set_animation()

func _process(delta):
	position += delta * player_speed * movement_vec.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
