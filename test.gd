extends Node2D

# Demo scene for the special effects functionality, and music if you want to add a FunkStream and EDMStream to the Music singleton

func _ready() -> void:
#	Music.change_music_immediate(Music.FunkStream)
	await get_tree().create_timer(1.0).timeout
	await try_effect(preload("res://toolkit/nodes/effects/squash.tscn"), $Squash)
	await try_effect(preload("res://toolkit/nodes/effects/stretch.tscn"), $Stretch)
	var effects : Array[PackedScene] = [preload("res://toolkit/nodes/effects/squash.tscn"), preload("res://toolkit/nodes/effects/stretch.tscn")]
	var effect_times : Array[float] = [.2, .2]
	await try_multiple_effects(effects, effect_times, $SquashThenStretch)
	await try_effect(preload("res://toolkit/nodes/effects/explosion.tscn"), $ParticlesTest, 1.0)
	await get_tree().create_timer(5.0).timeout
#	await Music.change_music(Music.EDMStream, 3.0)
#	await Music.change_music(Music.EDMStream, 3.0)
#	Music.change_music_immediate(Music.EDMStream)


func try_multiple_effects(effect_scenes : Array[PackedScene], effect_times : Array[float], node) -> void:
	SpecialEffects.add_temporary_multi_effect_to(effect_scenes, effect_times, node)
	await get_tree().create_timer(0.4).timeout

func try_effect(effect_scene, node, with_time = .2) -> void:
	SpecialEffects.add_temporary_effect_to(effect_scene, with_time, node)
	await get_tree().create_timer(0.4).timeout
