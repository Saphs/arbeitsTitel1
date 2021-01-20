extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var arena_vec = Vector2(90, 90)
var player_start_pos = Vector2(0, 100)

const Player = preload("res://scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var landscape = load_tscn("res://scenes/landscape.tscn")
	var enemy_scene = load("res://scenes/Enemy.tscn")

	add_child(landscape)
	spawn_player()

	yield(get_tree().create_timer(0.7),"timeout")
	var enemy = enemy_scene.instance()
	enemy.position = random_position(arena_vec.x, arena_vec.y)
	add_child(enemy)


func load_tscn(tscn_path):
	var scene = load(tscn_path)
	var instance = scene.instance()
	return(instance)


func random_position(max_x, max_y):
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var x = rand.randf_range(-max_x,max_x)
	rand.randomize()
	var y = rand.randf_range(-max_y,max_y)
	return Vector2(x, y)

func spawn_player():
	var player = Player.instance()
	add_child(player)
