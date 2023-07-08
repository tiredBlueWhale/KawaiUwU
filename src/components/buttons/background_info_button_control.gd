@tool
class_name BackgroundInfoButton
extends HiddenButton

@export var label: Label
@export var time_per_letter: float = 0.01

var tween: Tween

func on_pressed():
	print("on_pressed")
	if tween != null && tween.is_running():
		tween.kill()
		label.visible_ratio = 0
	elif label.visible_ratio >= 1:
		label.visible_ratio = 0
	else:
		var duration: float = label.text.length() * time_per_letter
		tween = create_tween()
		tween.tween_property(label, "visible_ratio", 1, duration)

func _ready():
	if not Engine.is_editor_hint():
		assert(label != null, "AnimatedLabel does not exist")
		label.visible_ratio = 0
		pressed.connect(on_pressed)
