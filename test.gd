extends Node2D

var _is_running := false

# Demo scene for the special effects functionality, and music if you want to add a FunkStream and EDMStream to the Music singleton

func _on_run_effects_pressed() -> void:
	if not _is_running:
		_is_running = true
	#	Music.change_music_immediate(Music.FunkStream)
		await get_tree().create_timer(1.0).timeout
		await try_effect(preload("res://toolkit/nodes/effects/squash.tscn"), $Squash)
		await try_effect(preload("res://toolkit/nodes/effects/stretch.tscn"), $Stretch)
		var effects : Array[PackedScene] = [preload("res://toolkit/nodes/effects/squash.tscn"), preload("res://toolkit/nodes/effects/stretch.tscn")]
		var effect_times : Array[float] = [.2, .2]
		await try_multiple_effects(effects, effect_times, $SquashThenStretch)
		await try_effect(preload("res://toolkit/nodes/effects/explosion.tscn"), $ParticlesTest, 1.0)
		await try_effect(preload("res://toolkit/nodes/effects/damage.tscn"), $DamageEffect, .5)
		await try_effect(preload("res://toolkit/nodes/effects/round_hit.tscn"), $RoundHit, .60)
		
		effects = [preload("res://toolkit/nodes/effects/round_hit.tscn"), preload("res://toolkit/nodes/effects/explosion.tscn"), preload("res://toolkit/nodes/effects/damage.tscn")]
		await try_multiple_parallel_effects(effects, 1.0, $DamageCombo)
		await try_effect(preload("res://toolkit/nodes/effects/hit_stop.tscn"), $HitStop, .91)
		await try_effect(preload("res://toolkit/nodes/effects/shake.tscn"), $Shake, 1.0)
		$ShakeableCamera.shake()
		_is_running = false
#	await get_tree().create_timer(5.0).timeout
#	await Music.change_music(Music.EDMStream, 3.0)
#	await Music.change_music(Music.EDMStream, 3.0)
#	Music.change_music_immediate(Music.EDMStream)


func try_multiple_effects(effect_scenes : Array[PackedScene], effect_times : Array[float], node) -> void:
	SpecialEffects.add_temporary_multi_effect_to(effect_scenes, effect_times, node)
	await get_tree().create_timer(0.4).timeout

func try_effect(effect_scene, node, with_time = .2) -> void:
	SpecialEffects.add_temporary_effect_to(effect_scene, with_time, node)
	await get_tree().create_timer(0.4).timeout

func try_multiple_parallel_effects(effect_scenes : Array[PackedScene], max_time : float, node) -> void:
	SpecialEffects.add_temporary_parallel_multi_effect_to(effect_scenes, max_time, node)
	await get_tree().create_timer(max_time + .1).timeout
