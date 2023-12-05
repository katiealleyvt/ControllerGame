extends Node2D

enum InputTypes {XBOX, NINTENDO, PC}
const ButtonTypes = ["up", "down", "left", "right"]

const inputType = InputTypes.XBOX
var buttonType: String
var movementSpeed: int = 300

signal buttonPress(position)
# Called when the node enters the scene tree for the first time.
func _ready():
	add_button_type()
	$Texture.texture.set_region(Rect2(0,0,48,48))
	add_sound()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if(position.x < -100):
		queue_free()
	
	position.x += -(movementSpeed * delta)
	
			
	
func add_button_type():
	buttonType = ButtonTypes[randi() % len(ButtonTypes)]
	var fileToLoad: String
	
	if(inputType == InputTypes.XBOX):
		match buttonType:
			"up":
				fileToLoad = "res://assets/controller_gui/button_y.png"
			"down":
				fileToLoad = "res://assets/controller_gui/button_a.png"
			"left":
				fileToLoad = "res://assets/controller_gui/button_x.png"
			"right":
				fileToLoad = "res://assets/controller_gui/button_b.png"
	
	var buttonTexture = AtlasTexture.new()
	buttonTexture.set_atlas(load(fileToLoad))
	
	$Texture.set_texture(buttonTexture)
func add_sound():
	
	var audioFile
	
	match buttonType:
		"up":
			audioFile = load("res://assets/audio/ping/Retro Instrument - crystal - C00.wav")
		"down":
			audioFile = load("res://assets/audio/ping/Retro Instrument - crystal - C01.wav")
		"left":
			audioFile = load("res://assets/audio/ping/Retro Instrument - crystal - C02.wav")
		"right":
			audioFile = load("res://assets/audio/ping/Retro Instrument - crystal - C03.wav")
	$InputSound.stream = audioFile
