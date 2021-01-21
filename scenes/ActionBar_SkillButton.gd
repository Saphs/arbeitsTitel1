tool
extends CenterContainer

export (Texture) onready var texture setget set_texture, get_texture
export (int) onready var icon_index setget set_icon_index, get_icon_index

export (String) onready var key_bind_display setget set_key_bind_display, get_key_bind_display
export (String) onready var name_display setget set_name_display, get_name_display

export (String) var spell_name setget set_spell_name, get_spell_name

onready var icon = get_node("PanelContainer/VBoxContainer/HBoxContainer/SkillIcon")
onready var key_bind_label = get_node("PanelContainer/VBoxContainer/HBoxContainer/SkillIcon/Label")
onready var name_label = get_node("PanelContainer/VBoxContainer/Label")

var cooldown_time = 0
var cd_timer = Timer.new()

func set_texture(value):
	texture = value
	if (icon != null):
		icon.texture = value
	update()

func get_texture():
	return texture

func set_icon_index(value):
	icon_index = value
	if (icon != null):
		icon.icon_index = value
	update()

func get_icon_index():
	return icon_index

func set_key_bind_display(value):
	key_bind_display = value
	if (key_bind_label != null):
		key_bind_label.text = value
	update()

func get_key_bind_display():
	return key_bind_display

func set_name_display(value):
	name_display = value
	if (name_label != null):
		name_label.text = value
	update()

func get_name_display():
	return name_display

func set_spell_name(value):
	spell_name = value

func get_spell_name():
	return spell_name

func start_cooldown(triggered_spell, time):
	if (triggered_spell == spell_name):
		cooldown_time = time
		cd_timer.set_wait_time(time)
		add_child(cd_timer)
		cd_timer.start()

func deconstruct_timer():
	cd_timer.stop()
	remove_child(cd_timer)

func _ready():
	add_to_group("player_skill")
	cd_timer.connect("timeout", self, "deconstruct_timer")
	cd_timer.set_one_shot(true)
	icon.icon_index = self.icon_index
	icon.texture = self.texture
	key_bind_label.text = self.key_bind_display
	name_label.text = self.name_display

func _process(delta):
	if (icon != null && cd_timer != null && !cd_timer.is_stopped()):
		if (cooldown_time <= 0):
			icon.cd_percentile = 0
			icon.update()
		else:
			icon.cd_percentile = cd_timer.time_left / cooldown_time
			icon.update()
