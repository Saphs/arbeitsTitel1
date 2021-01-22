extends Node2D

func handle_fireball_spawned(fireball: Fireball, position: Vector2, direction: Vector2):
	fireball.global_position = position
	fireball.set_direction(direction)
	fireball.get_animation().flip_v = true if direction.x < 0 else false
	
	add_child(fireball)
