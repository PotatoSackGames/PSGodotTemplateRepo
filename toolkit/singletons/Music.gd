extends Node

@onready var _player = $AudioStreamPlayer

# It's easiest to create your music as different AudioStreams below by preloading them here; you can use threaded resource loading
# so that they load independently of one another, but make sure to load your starting song on the main thread and play it in your
# own ready function, if that's where you want it to play.

# No settings screen is provided in this toolkit _yet_, but you can use the concepts behind change_base_music_volume() and 
# change_base_sfx_volume() to create your own however you wish. 

func change_music(stream : AudioStream, over_time : float = 0.2):
	if _player.stream != stream:
		var original_volume = _player.volume_db
		var lower = create_tween()
		lower.tween_property(_player, "volume_db", -100, over_time)
		await lower.finished
		_player.stop()
		_player.stream = stream
		_player.play()
		var raise = create_tween()
		raise.tween_property(_player, "volume_db", original_volume, over_time)

func change_music_immediate(stream : AudioStream):
	if _player.stream != stream:
		_player.stop()
		_player.stream = stream
		_player.play()
	
func change_base_music_volume(value):
	AudioServer.set_bus_volume_db(1, value)

func change_base_sfx_volume(value):
	AudioServer.set_bus_volume_db(2, value)

func get_music_volume():
	return AudioServer.get_bus_volume_db(1)
	
func get_sfx_volume():
	return AudioServer.get_bus_volume_db(2)
