extends Node2D

func handle_fireball_spawned(fireball: Fireball, position: Vector2, direction: Vector2):
	fireball.global_position = position
	fireball.set_direction(direction)
	add_child(fireball)
