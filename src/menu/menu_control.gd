class_name MenuControl
extends SaveAreaContainer

@onready var start_button: Button = $HBoxContainer/MarginContainer/VBoxContainer/StartButton

signal start

func on_start_button_pressed():
	start.emit()

func _ready():
	start_button.pressed.connect(on_start_button_pressed)
