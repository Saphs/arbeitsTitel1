extends KinematicBody2D

export (int) var bullet_speed = 125 #pixels/se
export var direction = Vector2.ZERO
var velocity = Vector2.ZERO

enum AnimationDircetion {
	LEFT,
	RIGHT
}

var current_animation_direction: int = AnimationDircetion.LEFT setget set_animation_direction

func set_animation_direction(new_animation_direction: int):
	current_animation_direction = new_animation_direction


func _ready():
	print(self)


func _physics_process(delta):
	var collision = move_and_collide(direction * delta * bullet_speed)
