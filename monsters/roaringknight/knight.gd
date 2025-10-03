extends AfterImageSpawner

@onready var whiten_mat := material as ShaderMaterial
@export var whiten: bool = false
var whiten_timer: float = 0
var whiten_percent: float = 0

var circle

func _process(delta: float):
	super._process(delta)
	
	if whiten:
		whiten_timer += delta
		whiten_percent = clamp(whiten_timer, 0, 1)
		
		queue_redraw()
	else:
		whiten_timer = 0
		whiten_percent = 0


func _draw():
	whiten_mat.set_shader_parameter("whiten_amount", whiten_percent)


func spawn_circle():
	var circle_scene = preload("res://monsters/roaringknight/circle/RoaringCircle.tscn")
	circle = circle_scene.instantiate() as Sprite2D
	
	circle.position = position
	circle.z_index = z_index + 1
	
	circle.set("start_inner_color", Color(0,0,0,0.25))
	circle.set("goal_inner_color", Color(0,0,0,0.25))
	circle.set("start_outer_color", Color(1,1,1,0.75))
	circle.set("goal_outer_color", Color(0.5,0,0,0.75))
	circle.set("fade_speed", 14)
	
	circle.set("start_size", 0)
	circle.set("goal_size", 960)
	circle.set("growth", 20)
	
	get_parent().add_child(circle)


func remove_circle():
	circle.set("destroy_me", true)
