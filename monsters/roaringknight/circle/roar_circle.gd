extends Node2D

@export var start_inner_color: Color = Color(0,0,0,0)
@export var goal_inner_color: Color = Color(0,0,0,0)
@export var start_outer_color: Color = Color(0,0,0,0)
@export var goal_outer_color: Color = Color(0,0,0,0)
@export var fade_speed: float = 1

@export var start_size: float = 0
@export var goal_size: float = 0
@export var growth: float = 1

@export var destroy_me: bool = false

var current_inner_color: Color
var current_outer_color: Color
var current_size: float
var current_alpha: float = 1


func draw_circle_colour(center: Vector2, radius: float, col_center: Color, col_edge: Color, resolution: int = 64) -> void:
	if resolution < 3:
		push_error("draw_circle_colour: resolution must be >= 3")
		return

	# precompute outer ring points (Array of Vector2)
	var outer_points: Array = []
	for i in range(resolution):
		var angle = TAU * float(i) / float(resolution)
		outer_points.append(center + Vector2(cos(angle), sin(angle)) * radius)

	# draw triangle fan (center, p_i, p_{i+1})
	for i in range(resolution):
		var p1 = outer_points[i]
		var p2 = outer_points[(i + 1) % resolution]
		# draw_polygon takes a list of Vector2 points and optionally per-vertex colors
		draw_polygon([center, p1, p2], [col_center, col_edge, col_edge])


func approach(start: float, goal: float, step: float) -> float:
	if goal < start:
		step = -step
	
	var ret = clamp(start + step, min(start, goal), max(start, goal))
	return ret


func approach_color(start: Color, goal: Color, step: float) -> Color:		
	start.r = approach(start.r, goal.r, step)
	start.g = approach(start.g, goal.g, step)
	start.b = approach(start.b, goal.b, step)
	start.a = approach(start.a, goal.a, step)
	
	return start

func _ready():
	current_inner_color = start_inner_color
	current_outer_color = start_outer_color
	current_size = start_size


func _process(delta: float):
	queue_redraw()


func _draw():	
	if destroy_me:
		current_alpha = approach(current_alpha, 0, 1 / fade_speed)
		if current_alpha <= 0:
			queue_free()
	
	current_inner_color = approach_color(current_inner_color, goal_inner_color, 1 / fade_speed)
	current_outer_color = approach_color(current_outer_color, goal_outer_color, 1 / fade_speed)
	current_size = approach(current_size, goal_size, growth)
	
	current_inner_color.a = min(current_alpha, current_inner_color.a)
	current_outer_color.a = min(current_alpha, current_outer_color.a)
	draw_circle_colour(position, current_size, current_inner_color, current_outer_color)
