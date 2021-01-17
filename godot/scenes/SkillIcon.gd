extends Control


export (Texture) var texture setget _set_texture


func _set_texture(value):
	# If the texture variable is modified externally,
	# this callback is called.
	texture = value  # Texture was changed.
	update()  # Update the node's visual representation.

func _draw():
	draw_texture_rect_region (texture, Rect2(Vector2(0,0), Vector2(50, 50)), Rect2(Vector2(0,0), Vector2(50, 50)))
