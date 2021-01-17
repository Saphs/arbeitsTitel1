extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var landscape = load_tscn("res://scenes/landscape.tscn")
	var player = load_tscn("res://scenes/Player.tscn")
	var enemy_scene = load("res://scenes/Enemy.tscn")
	
	add_child(landscape)
	player.position = Vector2(0, 100)
	add_child(player)
	
	var rand = RandomNumberGenerator.new()
	var screen_size = get_viewport().get_visible_rect().size

	rand.randf_range(0.3, 0.7)
	yield(get_tree().create_timer(0.7),"timeout")
	var enemy = enemy_scene.instance()
	rand.randomize()
	var x = rand.randf_range(0,screen_size.x)
	print(x)
	rand.randomize()
	var y = rand.randf_range(0,screen_size.y)
	enemy.position = Vector2(x, y)
	add_child(enemy)
	
	
func load_tscn(tscn_path):
	var scene = load(tscn_path)
	var instance = scene.instance()
	return(instance)
