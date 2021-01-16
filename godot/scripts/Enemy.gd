extends Node


export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_node("Worminator").animation == "shoot" && get_node("Worminator").frame == get_node("Worminator").frames.get_frame_count("shoot")-1:
		shoot()
		get_node("Worminator").animation = "idle"
	
func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		get_node("Worminator").animation = "shoot"
	
func shoot():
	var projectile = load("res://scenes/Projectile.tscn")
	var bullet  = projectile.instance()
	add_child_below_node(get_tree().get_root().get_node("Game"), bullet )

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
