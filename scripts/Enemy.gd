extends Node


export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

enum State {
	ENRAGE,
	IDLE,
}

var current_state: int = State.IDLE setget set_state

var actor = null

func set_state(new_state: int):
	current_state = new_state


var projectile = preload("res://scenes/Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('enemies')
	shoot_timer()
	print(self)

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
	
	var player = get_tree().get_nodes_in_group("player")
	var enemy = get_node("Worminator")
	print(player[0].global_position)
	var projectile = load("res://scenes/Projectile.tscn")
	var bullet  = projectile.instance()
	bullet.scale = Vector2(1, 1)
	var direction = (player[0].global_position - enemy.global_position).normalized()
	print(bullet.get_node("AnimatedSprite"))
	
	if(direction.x < 0):
		bullet.get_node("Fireball_Hitbox").get_node("AnimatedSprite").flip_h = true
	else:
		bullet.get_node("Fireball_Hitbox").get_node("AnimatedSprite").flip_h = false
	
	bullet.get_node("Fireball_Hitbox").direction = direction
	add_child_below_node(get_tree().get_root().get_node("Game"), bullet )
