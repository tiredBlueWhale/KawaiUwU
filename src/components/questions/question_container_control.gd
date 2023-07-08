class_name QuestionContainer
extends VBoxContainer

var qustion_button = preload("res://src/components/questions/question_button.tscn")

func play_question(p_question: Question) -> void:
	var button= qustion_button.instantiate() as Button
	add_child(button)
	button.text = p_question.text
	button.pressed.connect(_on_button_pressed.bind(p_question.callable))

func _clear():
	for child in get_children():
		remove_child(child)
		child.queue_free()

func _on_button_pressed(callable: Callable) -> void:
	_clear()
	callable.call()

func _ready():
	if not Engine.is_editor_hint():
		_clear()
