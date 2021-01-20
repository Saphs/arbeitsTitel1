extends Node


export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

var projectile = preload("res://scenes/Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('enemies')
	shoot_timer()

func _process(delta):
	var enemy = get_node("Worminator")
	
	
	# Play death animation and remove object
	if enemy.animation == "death" && enemy.frame == enemy.frames.get_frame_count("death")-1:
		get_parent().remove_child(self)
		queue_free()
		print(get_tree())

func shoot_timer():
	var timer = Timer.new()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "shoot")
	add_child(timer)

	timer.start()


func shoot():
	var projectile = load("res://scenes/Projectile.tscn")
	var bullet  = projectile.instance()
	bullet.scale = Vector2(1, 1)
	add_child_below_node(get_tree().get_root().get_node("Game"), bullet )
