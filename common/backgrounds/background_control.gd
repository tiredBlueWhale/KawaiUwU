@tool
#@icon("res://icon.svg")
class_name BackgroundControl
extends Control

@onready var background_color_rect = $ColorRect
@onready var background_sprite = $Sprite2D

var _background_texture: Texture2D
@export var background_texture: Texture2D:
	get: return _background_texture
	set(new_background_texture): 
		set_background_texture(new_background_texture)

#var _background_color: Color
@export var background_color: Color:
	set(new_background_color): 
		background_color = new_background_color
		update_background_color()

enum FitMode {COVER, CONTAIN}
var _fit_mode = FitMode.COVER
@export var fit_mode = FitMode.COVER:
	get: return _fit_mode
	set(new_fit_mode):
		_fit_mode = new_fit_mode
		_on_resized()

var _anker_position = Vector2(.5, 1.0)
@export var anker_position = Vector2(.5, 1.0):
	get: return _anker_position
	set(new_anker_position):
		_anker_position = new_anker_position
		_on_resized()
		
func update_background_color() -> void:
	if background_color_rect != null && background_color != null:
		background_color_rect.color = background_color

func _on_resized():
	if background_texture == null || background_sprite == null:
		return
	var background_texture_size = background_texture.get_size()
	# Offset bottom-center
	background_sprite.offset = -background_texture_size * anker_position
	# Scale
	var scale_x = size.x / background_texture_size.x
	var scale_y = size.y / background_texture_size.y
	if fit_mode == FitMode.CONTAIN:
		if scale_x < scale_y:
			background_sprite.scale = Vector2(scale_x, scale_x)
		else:
			background_sprite.scale = Vector2(scale_y, scale_y)
	else:
		if scale_x < scale_y:
			background_sprite.scale = Vector2(scale_y, scale_y)
		else:
			background_sprite.scale = Vector2(scale_x, scale_x)
	# Positon
	background_sprite.position = size * anker_position
	# BackgroundItemContainer
	var background_item_container = get_node_or_null("BackgroundItemContainer")
	if background_item_container == null:
		print_debug("background_item_container is null")
		return
	if Engine.is_editor_hint():
		background_item_container.size = background_texture_size
	background_item_container.scale = background_sprite.scale
	var scaled_offset = background_sprite.offset * background_sprite.scale 
	background_item_container.position = background_sprite.position + scaled_offset

func set_background_texture(p_background_texture: Texture2D):
	_background_texture = p_background_texture
	if background_sprite == null:
		return
	background_sprite.texture = p_background_texture
	_on_resized()
	

func _ready():
	resized.connect(_on_resized)
	_on_resized()
	update_background_color()
	set_background_texture(background_texture)
#	if background_texture != null:
#		background_texture = background_texture
