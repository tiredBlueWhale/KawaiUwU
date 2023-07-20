@tool
class_name Character
extends Resource

@export var texture: Texture2D:
	set(new_value):
		texture = new_value
		emit_changed()
		
@export var display_name: String:
	set(new_value): 
		display_name = new_value
		emit_changed()
		
@export var intro_title: String:
	set(new_value): 
		intro_title = new_value
		emit_changed()
		
@export_multiline var intro_sub_title: String:
	set(new_value): 
		intro_sub_title = new_value
		emit_changed()
