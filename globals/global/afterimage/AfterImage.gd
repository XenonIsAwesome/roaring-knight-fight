extends Sprite2D

@export var fade_speed: float = 0.02
@export var initial_alpha: float = 0.6
@export var hspeed: float = 1
@export var vspeed: float = 0

var alpha: float = 0

func _ready():
	alpha = initial_alpha
	modulate.a = initial_alpha

func _process(delta: float) -> void:
	alpha -= fade_speed
	modulate.a = alpha
	
	if alpha <= 0:
		queue_free()
		
	var offset = Vector2(hspeed, vspeed);
	position += offset
