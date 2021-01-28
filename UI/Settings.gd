extends Node

const SAVE_PATH = "user://config_settings.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"screen": {
		"fullscreen": false 
	},
}


func _ready():
	#save_settings()
	var settings = load_settings()


func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	_config_file.save(SAVE_PATH)


func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != OK:
		print("Error while loading the settings. Error code: %s" % error)
		return []
	
	# Retrieve values
	var values = []
	for section in _settings.keys():
		for key in _settings[section].keys():
			var val = _settings[section][key]
			values.append(_config_file.get_value(section, key, val))
			print("%s: %s" % [key, val])
	return values
