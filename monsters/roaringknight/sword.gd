extends Sprite2D

@export var flash_times: int = 10
@export var flash_rate: int = 2
@export var flash_delay: float = 0.05

var initial_pos: Vector2 = Vector2.ZERO
var y_offset = -flash_times;

func appear():
	y_offset = -flash_times
	visible = false
	
	for i in range(flash_times):
		visible = i % flash_rate == 0
		y_offset = i
		await get_tree().create_timer(flash_delay).timeout
	
	visible = true

func _ready():
	initial_pos = position

func _process(delta: float) -> void:
	var offset: Vector2 = Vector2(0, y_offset)
	position = initial_pos + offset;
