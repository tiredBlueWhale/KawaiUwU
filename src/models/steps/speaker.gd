class_name Speaker
extends SpeakerText

func _init(p_speaker: CharacterControl = null):
	super("null" if p_speaker == null else p_speaker.get_speaker_name())
