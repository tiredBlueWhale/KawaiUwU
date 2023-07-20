@tool
class_name Border
extends Panel

#var _color: Color
@export var color: Color:
	get: 
		var style_box = get_theme_stylebox("panel") as StyleBoxFlat
		return style_box.border_color
	set(new_color):
		var style_box = get_theme_stylebox("panel") as StyleBoxFlat
		style_box.border_color = new_color

#func _ready():
#	var style_box = 
#	print(style_box.border_color)
