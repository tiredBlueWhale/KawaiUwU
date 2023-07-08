class_name Store
extends TransitionControl

@onready var back_button: Button = $Menu/BackButton

func on_back_button_pressed():
	visible = false
	closed.emit()

func play():
	visible = true

func _ready():
	visible = false
	back_button.pressed.connect(on_back_button_pressed)
