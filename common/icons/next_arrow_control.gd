@tool
class_name NextArrow
extends MarginContainer

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var margin: int = 16:
	set(new_margin):
		margin = new_margin
		update()

func update():
	if sprite == null:
		return
	var texture_size = sprite.texture.get_size()
	add_theme_constant_override("margin_top", margin)
	add_theme_constant_override("margin_left", margin)
	add_theme_constant_override("margin_bottom", margin)
	add_theme_constant_override("margin_right", margin)
	var margin_vector = Vector2(margin, margin)
	custom_minimum_size = texture_size + margin_vector * 2
	sprite.position = texture_size * .5
	sprite.position.y += margin

func on_visibility_changed():
	if visible:
		animation_player.play("next")
	else:
		animation_player.stop()

func _ready():
	update()
	visibility_changed.connect(on_visibility_changed)
