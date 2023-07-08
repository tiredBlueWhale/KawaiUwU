# Rename to AnimatedText?
class_name TextAnimated
extends Step

var text: String
var time_per_letter = 0.07
var is_append = false
var is_new_line = false
var is_inserted = false

func _init(p_text = ""):
	text = p_text

func speed(p_time_per_letter: float):
	time_per_letter = p_time_per_letter
	return self

func append():
	is_append = true
	return self

func new_line():
	is_new_line = true
	return self
	
func insert():
	is_inserted = true
	return self
