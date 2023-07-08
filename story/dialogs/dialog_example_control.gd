class_name DialogExample
extends DialogControl

@onready var background: BackgroundExample = $BackgroundExample
@onready var character: CharacterControl = $SaveArea/CharacterContainer/Character
@onready var store: Store = $Store
@onready var intro_example: IntroExample = $IntroExample

func answer_food(p_food: String) -> void:
	steps = [
		Dialog.new("So you prefer %s. Good to know." % [p_food]),
	]
	if !save_data.food.is_empty() && save_data.food != p_food:
		steps.append(
			Dialog.new("Wait ... I just had a Déjà-vu that you picked something different last time.")
				.disable_skip()
		)
	
	save_data.food = p_food
	var next_scene = load("res://story/dialogs/dialog_example.tscn")
	steps.append(Next.new(next_scene))
	play_steps(steps)

func start():
	character.init()
	play_steps([
		Func.new(character.appear).wait(),
		SpeakerText.new("???"),
#		Dialog.new([tr_n("There is %d apple.", "There are %d apples.", 1) % 1, "blub"]),
#		Dialog.new([tr_n("There is %d apple.", "There are %d apples.", 10) % 10]),
		Dialog.new("I will tell you now a long long story").disable_skip().speed(.5),
		Dialog.new("Hello my good friend, my name is Bob."),
		Dialog.new("And I just farted").new_line().auto(),
		Dialog.new("...").disable_input().speed(1).append(),
		Dialog.new("and it smells like rotten eggs.").append(),
		Dialog.new("It is not very polite to constantly interrupt someone !!!")
			.disable_skip()
			.speed(.1)
			.conditon(func(): return save_data.skip_counter > 2),
		Transition.new(intro_example),
		Speaker.new(character),
		Dialog.new("What is your favorite food?").auto(),
		Question.new("Chocolate", answer_food.bind("Chocolate")),
		Question.new("Strawberries", answer_food.bind("Strawberries")),
	])

func on_store_button_pressed():
	store.play()

func _ready():
	super()
	background.store_button.pressed.connect(on_store_button_pressed)
	start()
