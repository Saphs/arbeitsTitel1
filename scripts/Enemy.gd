extends Node

export var VELOCITY = 1000.0
export var TURNING = 0.7
export var FIRE_RATE = 0.01

export (PackedScene) var Projectile

enum State {
	ENRAGE,
	IDLE,
	SHOOT
}

var current_state: int = State.IDLE setget set_state

var actor = null

func set_state(new_state: int):
	current_state = new_state


signal shoot(bullet, direction, location)

var Fireball = preload("res://scenes/Fireball.tscn")

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
	
	var fireball_instance = Fireball.instance()
	var player = get_tree().get_nodes_in_group("player")
	
	var direction = (player[0].global_position - self.global_position).normalized()
	
	GlobalSignals.emit_signal("fireball_fired", fireball_instance, self.global_position , direction)
	
	
	var animation_sprite = get_node("W_AnimatedSprite")
	animation_sprite.animation = "shoot"
	#var player = get_tree().get_nodes_in_group("player")
	
	#var bullet  = projectile.instance()
	#var offset  = self.global_position - player[0].global_position
	
	#bullet.get_node("Fireball").get_node("AnimatedSprite").rotation = offset.angle();
	#bullet.get_node("Fireball").get_node("AnimatedSprite").flip_h = true
	#bullet.get_node("Fireball").get_node("AnimatedSprite").flip_v = true if (direction.x < 0) else false
	
	#if(direction.x < 0):
	#	bullet.get_node("Fireball").get_node("AnimatedSprite").flip_v = false
	
	#bullet.get_node("Fireball").direction = direction
	#add_child(bullet)
	#add_child_below_node(get_tree().get_root().get_node("Game"), bullet, true)

