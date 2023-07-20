class_name DialogContainer
extends MarginContainer

signal next

@onready var speaker_label: AnimatedLabel = $VBoxContainer/Speaker/PanelContainer/MarginContainer/AnimatedLabel
@onready var dialog_label: AnimatedLabel = $VBoxContainer/Dialog/PanelContainer/MarginContainer/AnimatedLabel
@onready var next_arrow: NextArrow = $VBoxContainer/Dialog/PanelContainer/MarginContainer/NextArrow
@onready var next_button: HiddenButton = $VBoxContainer/Dialog/PanelContainer/MarginContainer/HiddenButton

@export var save_data: SaveData

func play_text(p_text: TextAnimated) -> Tween:
	if p_text is SpeakerText:
		return speaker_label.set_text_animated(p_text)
	return dialog_label.set_text_animated(p_text)

func show_next_arrow():
	next_arrow.show()
	
func hide_next_arrow():
	next_arrow.hide()

func on_next():
	next.emit()

func _ready():
#	if not Engine.is_editor_hint():
	hide_next_arrow()
	next_button.pressed.connect(on_next)

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			if not event.is_pressed():
				on_next()
				if get_viewport() != null:
					get_viewport().set_input_as_handled()
