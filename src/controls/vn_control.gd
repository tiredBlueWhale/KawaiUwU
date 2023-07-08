class_name VNControl
extends MarginContainer

@export var is_auto_play = false
@export var save_data: SaveData

signal next(p_next_scene)

func _mouse_filter(p_mouse_filter: int) -> String:
	match p_mouse_filter:
		0: return "MOUSE_FILTER_STOP"
		1: return "MOUSE_FILTER_PASS"
		2: return "MOUSE_FILTER_IGNORE"
		_: return "MOUSE_FILTER_NOT_SUPPORTED"

func scan_nodes(node: Node):
	for child in node.get_children():
		if child is Control:
			var mouse_filter_info = "%s mouse: %s" % [child, _mouse_filter(child.mouse_filter)]
			if child.mouse_filter == MOUSE_FILTER_STOP:
				printerr(mouse_filter_info)
			else:
				print(mouse_filter_info)
		scan_nodes(child)

func _ready():
	assert(save_data != null, "SaveData not injected")
#	scan_nodes(self)
