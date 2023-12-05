extends Node2D


var isButtonInGoal : bool = false
var buttonInGoal : CharacterBody2D
var points = 0
var noteAttempted : bool = false
# Preloaded Scenes
var music_note: PackedScene = preload("res://scenes/buttons/button.tscn")

func _ready():
	spawn_note()
	$MusicNoteTimer.start()
	
func _process(_delta):
	
	if(isButtonInGoal and Input.is_action_pressed(buttonInGoal.buttonType)):
		
		
		
		# this could break if the order of this child changes, so future katie fix later plsssss
		buttonInGoal.get_child(1).texture.set_region(Rect2(48,0,48,48))
		
		var distanceFromGoal = abs(buttonInGoal.position.x - $UI/Goal.position.x)
		if(distanceFromGoal > 50):
			$UI/Goal.create_points_text("miss")
			points -= 150
			animate_scoreboard(Color.ORANGE_RED)
		elif (distanceFromGoal >30):
			$UI/Goal.create_points_text("ok")
			points += 50
			animate_scoreboard(Color.LAWN_GREEN)
		else:
			$UI/Goal.create_points_text("perfect")
			points += 150
			animate_scoreboard(Color.LAWN_GREEN)
		noteAttempted = true
		$TopUI/ScoreNumber.text = str(points)
		
		var sound = buttonInGoal.get_node("InputSound")
		sound.play()
		
		buttonInGoal.queue_free()
		buttonInGoal = null
		isButtonInGoal = false
	
		
func spawn_note():
	$MusicNoteTimer.wait_time = randf_range(0.5,2)
	
	var note_instance = music_note.instantiate() as Node2D
	
	note_instance.position.y = $UI/Goal.position.y
	note_instance.position.x = get_viewport().size.x
	note_instance.scale = Vector2(2.48, 2.48)
	
	$UI/MusicNotes.add_child(note_instance)
	
	noteAttempted = false



func _on_goal_button_entered_goal(button):
	buttonInGoal = button
	isButtonInGoal = true


func _on_goal_button_exited_goal(button):
	buttonInGoal = null
	isButtonInGoal = false
	if(!noteAttempted):
		points -= 150
		$TopUI/ScoreNumber.text = str(points)
		animate_scoreboard(Color.ORANGE_RED)
		button.queue_free()


func _on_music_note_timer_timeout():
	spawn_note()

func animate_scoreboard(color: Color):
	var originalColor : Color  = Color.WHITE
	$TopUI.set_modulate(color)
	$TopUI.set_scale(Vector2(1.3, 1.3))
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($TopUI, "modulate", originalColor, .5)
	tween.tween_property($TopUI, "scale", Vector2(1,1), .5)

