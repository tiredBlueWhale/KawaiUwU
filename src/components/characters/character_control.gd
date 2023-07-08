@tool
class_name CharacterControl
extends Sprite2D

var _character: Character
@export var character: Character:
	get: return _character
	set(new_character):
		if _character != null && _character.changed.is_connected(on_character_changed):
			_character.changed.disconnect(on_character_changed)
		_character = new_character
		if _character != null:
			_character.changed.connect(on_character_changed)

func set_character_texture(p_character_texture: Texture2D):
	texture = p_character_texture
	if p_character_texture == null:
		return
	var character_texture_size = p_character_texture.get_size()
	offset = Vector2(-character_texture_size.x * .5, -character_texture_size.y)

func on_character_changed():
	if character == null:
		return
	set_character_texture(character.texture)

func _ready():
	if not Engine.is_editor_hint():
		assert(character != null, "Character is null in CharacterControl")

# MARK Func

var tween: Tween

func _get_tween() -> Tween:
	if tween != null && tween.is_running():
		tween.kill()
	return create_tween()

func init(p_visibility = false):
	if p_visibility:
		modulate = Color.WHITE
	else:
		modulate = Color.TRANSPARENT
		
func get_speaker_name() -> String:
	if character != null && !character.display_name.is_empty():
		return character.display_name
	return "SpeakerName"
	
func appear(duration = 1) -> Tween:
	tween = _get_tween()
	tween.tween_property(self, "modulate", Color.WHITE, duration)
	return tween
	
func disappear(duration = 1) -> Tween:
	tween = _get_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, duration)
	return tween
