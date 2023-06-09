extends Node

@onready var _player = $AudioStreamPlayer

# Don't officially know if this works, testing in the next jam.
# Ideally would just have a list of streams in this file and then whatever changes the music would select one of them to change to.

func change_music(stream : AudioStream):
	var original_volume = _player.volume_db
	var lower = create_tween()
	lower.tween_property(_player, "volume_db", -100, 0.2)
	await lower.finished
	_player.stop()
	_player.stream = stream
	_player.play()
	var raise = create_tween()
	raise.tween_property(_player, "volume_db", original_volume, 0.2)

func change_music_immediate(stream : AudioStream):
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
