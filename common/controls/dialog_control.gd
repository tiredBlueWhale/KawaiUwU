#@icon("res://icon.svg")
class_name DialogControl
extends VNControl

@export var index = 0
@export var question_container: QuestionContainer
@export var dialog_container: DialogContainer

var steps: Array[Step] = []
var step: Step

func play_steps(p_steps: Array[Step]):
	steps = p_steps
	index = 0
	_play()

# MARK - Next

var next_tween: Tween

func _next(p_delay: float = -1) -> void:
	if p_delay > 0:
		if next_tween != null && next_tween.is_running():
			printerr("DialogControl: next_tween is killed before completion")
		next_tween = create_tween()
		next_tween.tween_interval(p_delay)
		await next_tween.finished
	index += 1
	if index < steps.size():
		_play()
	else:
		print("End of steps")

# Mark - Step Handeling

func _play_next(p_next: Next) -> void:
	next.emit(p_next.scene)

func _play_func(p_func: Func) -> void:
	var result = p_func.callable.call()
	if p_func.is_await:
		if result is Tween:
			await result.finished
		else:
			printerr("%s %s no tween returned" % [p_func.callable.get_object(), p_func.callable.get_method()])
	_next()

func _on_transition_closed(p_transition: Transition) -> void:
	if p_transition.transition_control.closed.is_connected(_on_transition_closed.bind(p_transition.transition_control)):
		p_transition.transition_control.closed.disconnect(_on_transition_closed.bind(p_transition.transition_control))
	_next()

func _play_transition(p_transition: Transition) -> void:
	if !p_transition.transition_control.closed.is_connected(_on_transition_closed.bind(p_transition)):
		p_transition.transition_control.closed.connect(_on_transition_closed.bind(p_transition))
	p_transition.transition_control.play()

func _handle_condition(p_step: Step) -> void:
	if p_step._condition == null:
		return
	
	var condition_result = true
	match typeof(p_step._condition):
		TYPE_CALLABLE:
			condition_result = p_step._condition.call()
		TYPE_BOOL:
			condition_result = p_step._condition
		_:
			print_debug("Type %s not supported" % [typeof(p_step._condition)])
	
	if !condition_result:
		_next()

func _play() -> void:
	step = steps[index]
	_handle_condition(step)
	
	if step is Pause:
		if is_auto_play:
			_next()
	elif step is TextAnimated:
		await _play_text(step)
	elif step is Question:
		question_container.play_question(step)
		_next()
	elif step is Next:
		_play_next(step)
	elif step is Func:
		await _play_func(step)
	elif step is Transition:
		_play_transition(step)
	else:
		printerr("step %s not supported in DialogControl" % [step])
		_next()

# MARK - Dialog

func _play_text(p_step: TextAnimated) -> void:
	var result = dialog_container.play_text(p_step)
	if result != null && result is Tween:
		await result.finished
	if p_step is Dialog:
		if p_step.is_input_disabled && step.delay_next < 0:
			printerr("Story can't progress input_disabled && step.auto_time_next < 0. Use Pause() to pause steps")
			printerr("Story will be automatically progressed")
			_next()
		elif step.delay_next >= 0:
			_next(step.delay_next)
		else:
			dialog_container.show_next_arrow()
	else:
		_next()

func _handle_step_input():
	if step is Dialog:
		if step.is_input_disabled:
			return
		if dialog_container.dialog_label.is_animation_running():
			save_data.add_skip_counter()
			if step.is_skip_enabled:
				dialog_container.dialog_label.kill_text_animation()
		elif step.delay_next < 0:
			_next()
			dialog_container.hide_next_arrow()

#func _unhandled_key_input(event):
#	if event is InputEventKey:
#		if event.keycode == KEY_SPACE:
#			if not event.is_pressed():
#				_handle_step_input()
#				if get_viewport() != null:
#					get_viewport().set_input_as_handled()
#		elif event.is_pressed():
#			if index + 1 < steps.size():
#				steps.insert(
#					index + 1, 
#					Dialog.new("You just pressed %s ...Why" % OS.get_keycode_string(event.keycode))
#						.auto()
#						.speed(0.01)
#						.insert()
#				)

# MARK - Ready
				
func _ready():
	super()
	assert(dialog_container != null, "TextContainer does not exist")
	assert(question_container != null, "QuestionContainer does not exist")
	save_data.reset_skip_counter()
	dialog_container.save_data = save_data
	dialog_container.next.connect(_handle_step_input)
