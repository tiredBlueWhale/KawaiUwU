@tool
class_name HiddenButton
extends Button

@export var is_hidden: bool:
	get: return self_modulate == Color.TRANSPARENT
	set(p_is_hidden):
		self_modulate = Color.TRANSPARENT if p_is_hidden else Color.WHITE
