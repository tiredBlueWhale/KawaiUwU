class_name Step
extends Resource

var is_await: bool = false
var delay_next: float = -1.0
var _condition: Variant
	
func wait(p_is_await: bool = true) -> Step:
	is_await = p_is_await
	return self

func delay(p_delay_next: float) -> Step:
	delay_next = p_delay_next
	return self
	
func conditon(p_condition: Variant):
	_condition = p_condition
	return self
