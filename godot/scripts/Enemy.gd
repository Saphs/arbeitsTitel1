extends Node


export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01


# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_timer()

func _process(delta):
	var enemy = get_node("Worminator")
	
	
	# Play death animation and remove object
	if enemy.animation == "death" && enemy.frame == enemy.frames.get_frame_count("death")-1:
		get_parent().remove_child(self)
		queue_free()
		print(get_tree())
	
func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		get_node("Worminator").animation = "shoot"
		
	if Input.is_action_just_pressed("ui_down"):
		get_node("Worminator").animation = "death"
	

func shoot_timer():
	# Create a timer node
	var timer = Timer.new()

	# Set timer interval
	timer.set_wait_time(1.0)

	# Set it as repeat
	timer.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer.connect("timeout", self, "shoot")

	# Add to the tree as child of the current node
	add_child(timer)

	timer.start()


func shoot():
	var projectile = load("res://scenes/Projectile.tscn")
	var bullet  = projectile.instance()
	bullet.scale = Vector2(5, 5)
	add_child_below_node(get_tree().get_root().get_node("Game"), bullet )
