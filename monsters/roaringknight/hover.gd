extends Node2D

var initial_pos: Vector2 = Vector2.ZERO

@export var hovering: bool = true
@export var hover_speed: float = 2.0
@export var hover_height: float = 6.0

var actually_hovering: bool
var hover_time: float = 0.0

@export var shaking: bool = false
@export var shake_max: float = 1.0


func _ready():
	actually_hovering = hovering
	initial_pos = position 


func _process(delta: float) -> void:
	var offset: Vector2 = Vector2(
		get_x_position_offset(), 
		get_y_position_offset(delta)
	)
	position = initial_pos + offset;


func get_x_position_offset() -> float:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var offset: float = 0.0
	
	if shaking:
		offset += rng.randf_range(-shake_max, shake_max)
	
	return offset


func get_y_position_offset(delta: float) -> float:
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	var offset: float = 0;
	
	if actually_hovering:
		hover_time += delta
		offset += cos((hover_time / hover_speed) * TAU) * hover_height
	else:
		hover_time = 0
	
	if round(offset) == 0:
		actually_hovering = hovering
	
	if shaking:
		offset += rng.randf_range(-shake_max, shake_max)
	
	return offset
