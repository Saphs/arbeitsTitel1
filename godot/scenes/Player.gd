extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		get_node("P_AnimatedSprite").animation = "P_walkUp"
	if Input.is_action_just_pressed("ui_down"):
		get_node("P_AnimatedSprite").animation = "P_walkDown"
	if Input.is_action_just_pressed("ui_left"):
		get_node("P_AnimatedSprite").animation = "P_walkLeft"
	if Input.is_action_just_pressed("ui_right"):
		get_node("P_AnimatedSprite").animation = "P_walkRight"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
