class_name AnimatedLabel
extends Label

var tween: Tween
var text_inserted_ended: String = ""

func is_animation_running() -> bool:
	return tween != null && tween.is_running()
	
func kill_text_animation() -> void:
	visible_ratio = 1
	if is_animation_running():
		tween.kill()
		tween.finished.emit()

func get_text_translated(p_text_animated: TextAnimated) -> String:
	if p_text_animated.is_append:
		return " " + tr(p_text_animated.text)
	elif p_text_animated.is_new_line:
		return "\n" + tr(p_text_animated.text)
	else:
		return tr(p_text_animated.text)

func set_text_animated(p_text_animated: TextAnimated) -> Tween:
	var text_translated = get_text_translated(p_text_animated)
	var text_translated_length = text_translated.length()
	
	if p_text_animated.is_inserted && text_inserted_ended.is_empty():
		text_inserted_ended = text
	elif !p_text_animated.is_inserted && !text_inserted_ended.is_empty():
		text = text_inserted_ended
		text_inserted_ended = ""
	
	if p_text_animated.time_per_letter <= 0:
		if is_animation_running():
			print_debug("AnimatedLabel is cancelled before beeing finnished")
			tween.kill()
		visible_ratio = 1
		if p_text_animated.is_append || p_text_animated.is_new_line:
			text += text_translated
		else:
			text = text_translated
		return null
	
	if is_animation_running():
		print_debug("AnimatedLabel is cancelled before beeing finnished")
		tween.kill()
	if !p_text_animated.is_append && !p_text_animated.is_new_line:
		text = ""
	var old_length = text.length()
	var new_length = old_length + text_translated_length
	text += text_translated
	
	if text_translated_length > 0:
		visible_ratio = float(old_length) / float(new_length)
		
	var duration = float(text_translated_length) * float(p_text_animated.time_per_letter)
	tween = get_tree().create_tween()
	tween.tween_property(self, "visible_ratio", 1, duration)
	return tween

func _ready():
	if not Engine.is_editor_hint():
		visible_ratio = 0
