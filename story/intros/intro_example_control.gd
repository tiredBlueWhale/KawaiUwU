class_name IntroExample
extends TransitionControl

@onready var character_control: CharacterControl = $Control/Character

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var title: Label = $Control/Title
@onready var sub_title: Label = $Control/SubTitle
@onready var close_button: Button = $Control/Button

func on_close():
	if animation_player.is_playing():
		return
	visible = false
	closed.emit()

func play():
	animation_player.play("intro_1")
	visible = true

func _ready():
	visible = false
	title.text = character_control.character.intro_title
	sub_title.text = character_control.character.intro_sub_title
	close_button.pressed.connect(on_close)

func _unhandled_key_input(event):
	if not visible:
		return
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			if not event.is_pressed():
				on_close()
				get_viewport().set_input_as_handled()
