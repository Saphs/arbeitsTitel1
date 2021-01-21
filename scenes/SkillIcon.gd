tool
extends Control


export (Texture) var texture setget _set_texture
export (int) var icon_target_size setget _set_icon_target_size
export (Vector2) var icon_texture_section_size setget _set_icon_texture_section_size
export (int) var icon_index setget _set_icon_index
export (int) var texture_map_row_cnt setget _set_texture_map_row_cnt
export (int) var texture_map_column_cnt setget _set_texture_map_column_cnt

var cd_percentile = 0

func _set_texture(value):
	texture = value
	update()

func _set_icon_target_size(value):
	icon_target_size = value
	update()

func _set_icon_index(value):
	icon_index = value
	update()

func _set_icon_texture_section_size(value):
	icon_texture_section_size = value
	update()

func _set_texture_map_row_cnt(value):
	texture_map_row_cnt = value
	update()

func _set_texture_map_column_cnt(value):
	texture_map_column_cnt = value
	update()

func _draw():
	if ( texture_map_column_cnt > 0 && texture_map_row_cnt > 0 ):
		var texture_location = Rect2(Vector2((icon_index % texture_map_column_cnt) * icon_texture_section_size.x, (icon_index / texture_map_row_cnt) * icon_texture_section_size.y), icon_texture_section_size)
		var target_location = Rect2(Vector2(0,0), Vector2(icon_target_size, icon_target_size))
		draw_texture_rect_region(texture, target_location, texture_location)
	else:
		print("Skill with 'texture_map_column_cnt' or 'texture_map_row_cnt' <= 0 found. Defaulting to row index 0 and column index 0.")
		draw_texture_rect_region (texture, Rect2(Vector2(0,0), Vector2(icon_target_size, icon_target_size)), Rect2(Vector2(0,0), icon_texture_section_size))
	draw_rect(Rect2(Vector2(0, icon_target_size - (icon_target_size * cd_percentile)), Vector2(icon_target_size, icon_target_size * cd_percentile)), Color(1.0, 0.0, 0.0, 0.5))
