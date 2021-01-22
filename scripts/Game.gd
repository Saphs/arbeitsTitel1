extends Node2D

const Player = preload("res://scenes/Player.tscn")
const Enemy  = preload("res://scenes/Worminator.tscn")

var arena_vec = Vector2(90, 90)
var player_start_pos = Vector2(0, 100)



onready var fireball_manager = $FireballManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.connect("fireball_fired", fireball_manager, "handle_fireball_spawned")
	
	
	var landscape = load_tscn("res://scenes/landscape.tscn")
	add_child(landscape)
	
	spawn_player()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()

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

func spawn_player()-> void:
	var player = Player.instance()
	add_child(player)

func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = random_position(arena_vec.x, arena_vec.y)
	add_child(enemy)
