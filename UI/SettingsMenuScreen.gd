extends CanvasLayer



func _ready():
	var checkButton = get_tree().get_root().get_node("SettingsMenuScreen").find_node("CheckButton")
	checkButton.set_pressed(Globals.get('fullscreen'))


func _on_BackButton_pressed():
	get_tree().change_scene("res://UI/MainMenuScreen.tscn")


func _on_CheckButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	Globals.set('fullscreen', OS.window_fullscreen)
