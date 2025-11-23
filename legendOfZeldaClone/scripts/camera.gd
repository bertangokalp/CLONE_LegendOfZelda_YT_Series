extends Camera2D

@onready var screenSize: Vector2 = get_viewport_rect().size
@onready var player = get_parent().get_node("Player")

func _ready() -> void:
	set_screen_pos()
	await get_tree().process_frame
	position_smoothing_enabled = true
	position_smoothing_speed = 5.0

func _process(delta: float) -> void:
	set_screen_pos()

func set_screen_pos():
	var playerPOS = player.global_position
	var x = floor(playerPOS.x / screenSize.x) * screenSize.x + screenSize.x / 2
	var y = floor(playerPOS.y / screenSize.y) * screenSize.y + screenSize.y / 2
	global_position = Vector2(x,y)
