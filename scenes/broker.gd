extends Node

onready var player = get_node("../Player")
signal player_change

func _ready():
	print("[Broker] Initialization:")
	if (player != null):
		print("[Broker] Detected player node. Connecting to 'state_change' signal. Listen on 'player_change' for updates.")
		player.connect("state_change", self, "_on_player_state_change")
	else:
		printerr("[Broker] No player node detected. No 'player_change' events will be emitted.")

func _on_player_state_change(player):
	emit_signal("player_change", player)

