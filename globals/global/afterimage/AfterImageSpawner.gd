extends Sprite2D
class_name AfterImageSpawner

@export var enable_after_image: bool = false
@export var after_image_rate: float = 5   # how many per second
@export var after_image_speeds: Vector2 = Vector2.ZERO

var _timer: float = 0.0

func _process(delta: float) -> void:
	if not enable_after_image:
		return

	_timer += delta
	var interval = 1.0 / after_image_rate
	if _timer >= interval:
		_timer = 0
		spawn_afterimage()
		

func spawn_afterimage():
	var afterimage_scene = preload("res://globals/global/afterimage/AfterImage.tscn")  # make scene with AfterImage.gd
	var afterimage = afterimage_scene.instantiate() as Sprite2D

	# Copy texture data
	afterimage.texture = texture
	afterimage.hframes = hframes
	afterimage.vframes = vframes
	afterimage.frame = frame
	
	# Copy position and sprite data
	afterimage.position = global_position
	afterimage.rotation = rotation
	afterimage.scale = scale
	afterimage.flip_h = flip_h
	afterimage.flip_v = flip_v
	
	afterimage.z_index = z_index - 1
	
	afterimage.set("hspeed", after_image_speeds.x)
	afterimage.set("vspeed", after_image_speeds.y)

	get_parent().add_child(afterimage)
