class_name SaveData
extends Resource

@export var userName: String = "UserName"
@export var food: String = ""
@export var skip_counter: int = 0
@export var skip_counter_total: int = 0

func add_skip_counter(p_skip_counter = 1):
	skip_counter += p_skip_counter
	skip_counter_total += p_skip_counter

func reset_skip_counter():
	skip_counter = 0
