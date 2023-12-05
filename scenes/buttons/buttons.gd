extends Control

enum InputType {XBOX, NINTENDO, PC}

var inputType = InputType.XBOX


# Called when the node enters the scene tree for the first time.
func _ready():
	if(inputType == InputType.XBOX):
		$Container/X.set_position(Vector2(0, 48))
		$Container/Y.set_position(Vector2(48, 0))
		$Container/A.set_position(Vector2(48, 96))
		$Container/B.set_position(Vector2(96, 48))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Container/X.texture.set_region(Rect2(0,0,48,48)) # up
	$Container/B.texture.set_region(Rect2(0,0,48,48)) # down
	$Container/Y.texture.set_region(Rect2(0,0,48,48)) # left
	$Container/A.texture.set_region(Rect2(0,0,48,48)) # right
	
	if(inputType == InputType.NINTENDO):
		if Input.is_action_pressed("up"):
			$Container/X.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("down"):
			$Container/B.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("left"):
			$Container/Y.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("right"):
			$Container/A.texture.set_region(Rect2(48,0,48,48))
		
	if(inputType == InputType.XBOX):
		if Input.is_action_pressed("up"):
			$Container/Y.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("down"):
			$Container/A.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("left"):
			$Container/X.texture.set_region(Rect2(48,0,48,48))
		if Input.is_action_pressed("right"):
			$Container/B.texture.set_region(Rect2(48,0,48,48))
			
		
	
	
		
