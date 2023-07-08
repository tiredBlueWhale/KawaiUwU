@tool
class_name BackgroundItemContainer
extends Control

@onready var border = $Border
@export var has_border: bool:
	get: return false if border == null else border.visible
	set(value):
		if border != null:
			border.visible = value

