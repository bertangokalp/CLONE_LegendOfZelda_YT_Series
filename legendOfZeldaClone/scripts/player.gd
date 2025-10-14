extends CharacterBody2D

@export var speed = 66 #hızı tanımladım
@onready var playerANIM = $AnimationPlayer

var currentDIR = "none"
var health = 100
var playerALIVE = true

func movement():
	var moveDIR = Input.get_vector("walkLEFT", "walkRIGHT", "walkUP", "walkDOWN")
	velocity = moveDIR * speed

func Animations():
	if velocity.length() == 0:
		playerANIM.stop()
	else:
		var dir = "Up"
		if velocity.x > 0:
			dir = "Right"
		elif velocity.x < 0:
			dir = "Left"
		elif velocity.y < 0:
			dir = "Down"
		playerANIM.play("walk" + dir)

func _physics_process(delta: float) -> void:
	movement()
	Animations()
	move_and_slide()
