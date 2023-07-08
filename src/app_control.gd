class_name AppContainer
extends MarginContainer

@onready var menu_control: MenuControl = $Menu

@export var save_data: SaveData

var scene: PackedScene = preload("res://story/dialogs/dialog_example.tscn")
var scene_instance: VNControl

func next(p_scene: PackedScene) -> void:
	if scene_instance != null:
		remove_child(scene_instance)
		scene_instance.queue_free()
	scene_instance = p_scene.instantiate() as VNControl
	scene_instance.save_data = save_data
	add_child(scene_instance)
	scene_instance.next.connect(next)

func on_start():
	menu_control.hide()
	next(scene)

func _ready():
	save_data = SaveData.new()
	menu_control.start.connect(on_start)
	
	
