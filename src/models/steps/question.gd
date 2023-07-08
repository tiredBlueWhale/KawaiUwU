class_name Question
extends Step

var text: String
var callable: Callable

func _init(p_text = "", p_callable = null):
	text = p_text
	callable = p_callable
