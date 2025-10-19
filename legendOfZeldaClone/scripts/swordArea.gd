extends Area2D

var speed = 100
var dmg

func _ready() -> void:
	get_parent().global_position

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func setDamage(damage):
	print(damage)
	dmg = damage

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.dealDamage(dmg)
