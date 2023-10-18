extends Camera2D

func shake(amount = 0.5) -> void:
	var shake_effect = preload("res://Toolkit/Nodes/effects/shake.tscn").instantiate()
	shake_effect.trauma = amount
	var result = SpecialEffects.add_premade_temporary_effect_to(shake_effect, 0.5, self)
