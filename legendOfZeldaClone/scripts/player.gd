extends CharacterBody2D

@export var speed = 66 #hızı tanımladım
@onready var sword = preload("res://scenes/swordArea.tscn")
@onready var playerANIM = $AnimationPlayer

var dmg = 15
var amount = 30
var attackDetector = false
var enemyInAttackRange = false
var enemyAttackCoolDown = true
var currentDIR = "none"
var health = 100
var playerALIVE = true

func movement():
	var moveDIR = Input.get_vector("walkLEFT", "walkRIGHT", "walkUP", "walkDOWN")
	velocity = moveDIR * speed

func Animations():
	if velocity.length() == 0:
		if attackDetector == false:
			playerANIM.stop()
	else:
		if attackDetector == false:
			var dir = "Up"
			$HandPos.rotation_degrees = 90
			if velocity.x > 0:
				dir = "Right"
				$HandPos.rotation_degrees = 0
			elif velocity.x < 0:
				dir = "Left"
				$HandPos.rotation_degrees = 180
			elif velocity.y < 0:
				dir = "Down"
				$HandPos.rotation_degrees = -90
			playerANIM.play("walk" + dir)

func shoot():
	var s = sword.instantiate()
	add_child(s)
	s.setDamage(dmg)
	s.transform = $HandPos.transform
	s.position = $HandPos.global_position

func attack():
	if Input.is_action_just_pressed("attack"):
		Global.playerCurrentAttack = true #attack yapabiliyorum
		attackDetector = true
		var dir = currentDIR
		if velocity.x < 0:
			dir = "Left"
			$dealAttackTimer.start()
			playerANIM.play("attack" + dir)
		elif velocity.x > 0:
			dir = "Right"
			$dealAttackTimer.start()
			playerANIM.play("attack" + dir)
		elif velocity.y < 0:
			dir = "Down"
			$dealAttackTimer.start()
			playerANIM.play("attack" + dir)
		elif velocity.y > 0:
			dir = "Up"
			$dealAttackTimer.start()
			playerANIM.play("attack" + dir)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		if amount > 0:
			amount = amount - 1
			shoot()

func _physics_process(delta: float) -> void:
	movement()
	Animations()
	move_and_slide()
	attack()

func _on_deal_attack_timer_timeout() -> void:
	$dealAttackTimer.stop()
	Global.playerCurrentAttack = false
	attackDetector = false
