@tool
class_name SaveAreaContainer
extends MarginContainer

@onready var border = get_node_or_null("Border")
@export var has_border: bool:
	set(new_has_border):
		has_border = new_has_border
		update_border()

func update_border():
	if border != null:
		border.visible = has_border

func _on_resize():
	var save_area = DisplayServer.get_display_safe_area()
	var screen_size = DisplayServer.screen_get_size()
	var view_size = get_size()
	
	var aspect_y = view_size.y / screen_size.y
	var aspect_x = view_size.x / screen_size.x
	
	var save_area_top = save_area.position.y * aspect_y
	var save_area_left = save_area.position.x * aspect_x
	var save_area_bottom = view_size.y - save_area.end.y * aspect_y
	var save_area_right = view_size.x - save_area.end.x * aspect_x

	if ["Android, iOS"].has(DisplayServer.get_name()):
		add_theme_constant_override("margin_top", save_area_top)
		add_theme_constant_override("margin_left", save_area_left)
		add_theme_constant_override("margin_bottom", save_area_bottom)
		add_theme_constant_override("margin_right", save_area_right)

func _ready():
	resized.connect(_on_resize)
	_on_resize()
	update_border()
