extends AfterImageSpawner

@export var hovering: bool = true
@export var hover_speed: float = 2.0
@export var hover_height: float = 6.0

var actually_hovering: bool
var hover_time: float = 0.0
var initial_y = 0

func _ready():
	actually_hovering = hovering
	initial_y = position.y

func _process(delta: float) -> void:
	super._process(delta)
	
	position.y = initial_y + get_y_position_offset(delta)

func get_y_position_offset(delta: float) -> float:
	var offset: float = 0;
	
	if actually_hovering:
		hover_time += delta
		offset += cos((hover_time / hover_speed) * TAU) * hover_height
	else:
		hover_time = 0
	
	if round(offset) == 0:
		actually_hovering = hovering
	
	return offset
