extends Area2D


signal buttonEnteredGoal(body)
signal buttonExitedGoal(body)

var pointsText : PackedScene = preload("res://scenes/points_text.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	buttonEnteredGoal.emit(body)
	


func _on_body_exited(body):
	buttonExitedGoal.emit(body)

func create_points_text(text: String):
	var posOptions = $PointParticles/Positions.get_children()
	var randPos : Vector2 = posOptions[randi() % len(posOptions)].position
	
	var pointParticle = pointsText.instantiate() as Node2D
	var textSprite = pointParticle.get_node("TextSprite") as Sprite2D
	if(text == "perfect"):
		textSprite.set_texture(load("res://assets/text/sprites/perfect.png"))
		pointParticle.modulate = "5AFF65"
	elif(text == "ok"):
		textSprite.set_texture(load("res://assets/text/sprites/ok.png"))
		pointParticle.modulate = "5A70FF"
	else:
		textSprite.set_texture(load("res://assets/text/sprites/miss.png"))
		pointParticle.modulate = "FF464F"
		
		
	pointParticle.position = randPos
	pointParticle.scale = Vector2(1.5, 1.5)
	
	$PointParticles.add_child(pointParticle)
	
	await get_tree().create_timer(.8).timeout
	pointParticle.queue_free()
