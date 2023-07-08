@tool
class_name PivotCenterLabel
extends Label

func on_item_rect_changed():
	pivot_offset = size / 2
	
func _ready():
	item_rect_changed.connect(on_item_rect_changed)
	on_item_rect_changed()
