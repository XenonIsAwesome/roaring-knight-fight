extends Node2D


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
