extends Area2D
class_name Fireball


export (int) var speed = 1 #pixels/sec
var direction := Vector2.ZERO

enum AnimationDircetion {
	LEFT,
	RIGHT
}

var current_animation_direction: int = AnimationDircetion.LEFT setget set_animation_direction

func _ready() -> void:
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var n_s = rand.randf_range(1,3)
	self.speed = 0.5
	print($f_animation.visible)


func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func set_animation_direction(new_animation_direction: int):
	current_animation_direction = new_animation_direction

func get_animation() -> Node:
	return self.get_node("f_animation")


func _on_Fireball_body_entered(body):
	print("Body:",body)
	self.queue_free()
