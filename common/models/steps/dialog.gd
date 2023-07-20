class_name Dialog
extends TextAnimated

var is_input_disabled = false
var is_skip_enabled = true

func _init(p_dialog: String):
	super(p_dialog)
	is_await = true
	
func disable_input(p_delay = 0.0):
	is_input_disabled = true
	return auto(p_delay)

func disable_skip():
	is_skip_enabled = false
	return self

func auto(p_delay = 0.0):
	return delay(p_delay)
