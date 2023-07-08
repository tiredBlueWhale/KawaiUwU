class_name DialogContainer
extends MarginContainer

@onready var speaker_label: AnimatedLabel = $VBoxContainer/Speaker/PanelContainer/MarginContainer/AnimatedLabel
@onready var dialog_label: AnimatedLabel = $VBoxContainer/Dialog/PanelContainer/MarginContainer/AnimatedLabel
@onready var next_arrow: NextArrow = $VBoxContainer/Dialog/PanelContainer/MarginContainer/NextArrow

@export var save_data: SaveData

func play_text(p_text: TextAnimated) -> Tween:
	if p_text is SpeakerText:
		return speaker_label.set_text_animated(p_text)
	return dialog_label.set_text_animated(p_text)

func show_next_arrow():
	next_arrow.show()
	
func hide_next_arrow():
	next_arrow.hide()
	
func _ready():
	if not Engine.is_editor_hint():
		hide_next_arrow()
