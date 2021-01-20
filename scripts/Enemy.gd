extends Node


export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

enum State {
	ENRAGE,
	IDLE,
	SHOOT
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
	var animation_sprite = get_node("W_AnimatedSprite")
	
	if animation_sprite.animation == "shoot" && animation_sprite.frame == animation_sprite.frames.get_frame_count("shoot")-1:
		animation_sprite.animation = "idle"
	
	
	# Play death animation and remove object
	if animation_sprite.animation == "death" && animation_sprite.frame == animation_sprite.frames.get_frame_count("death")-1:
		get_parent().remove_child(self)
		queue_free()
		print(get_tree())

func shoot_timer():
	var timer = Timer.new()
	timer.set_wait_time(2.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "shoot")
	add_child(timer)

	timer.start()


func shoot():
	var animation_sprite = get_node("W_AnimatedSprite")
	animation_sprite.animation = "shoot"
	var player = get_tree().get_nodes_in_group("player")
	
	var bullet  = projectile.instance()
	var direction = (player[0].global_position - self.global_position).normalized()
	
	if(direction.x < 0):
		bullet.get_node("Fireball").get_node("AnimatedSprite").flip_h = true
	else:
		bullet.get_node("Fireball").get_node("AnimatedSprite").flip_h = false
	
	bullet.get_node("Fireball").direction = direction
	add_child(bullet)
	#add_child_below_node(get_tree().get_root().get_node("Game"), bullet, true)
