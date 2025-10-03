extends Node2D

enum Animations {
	TURNING, DROOP, EXIT_DROOP, CHARGE_ROAR, ROARING, IDLE_SWORD, IDLE_NO_SWORD
}

@export var p_animation: Animations = Animations.IDLE_SWORD

func intro():
	$AnimationPlayer.play("idle_aura_farming")
	await get_tree().create_timer(1.0).timeout
	
	$AnimationPlayer.play("turning")
	await get_tree().create_timer(3.0).timeout
	
	$AnimationPlayer.play("droop")
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("exit_droop")
	await get_tree().create_timer(0.6).timeout
	
	$Knight.hovering = false
	$AnimationPlayer.play("idle_no_sword")
	await get_tree().create_timer(1).timeout
	
	$AudioStreamPlayer.stream = await preload("res://monsters/roaringknight/res/snd_knight_stretch.wav")
	$Knight.enable_after_image = false;
	$AnimationPlayer.play("charge_roar")
	await get_tree().create_timer(0.5).timeout
	$AudioStreamPlayer.play()
	await get_tree().create_timer(2.53).timeout
	
	$AudioStreamPlayer.stream = await preload("res://monsters/roaringknight/res/snd_roaringknight_roar.wav")
	$Knight.after_image_dir.y = $Knight.after_image_dir.x
	$Knight.enable_after_image = true;
	$AnimationPlayer.play("roar")
	$AudioStreamPlayer.play()
	await get_tree().create_timer(7).timeout

	$AudioStreamPlayer.stream = await preload("res://globals/sounds/music/mus_black_knife.ogg")
	$Knight.after_image_dir.y = 0
	$Knight.hovering = true
	$Knight.enable_after_image = true;
	$AnimationPlayer.play("idle_sword")
	$AudioStreamPlayer.play()

func _ready():
	intro()

#func _process(delta: float):
	#match p_animation:
		#Animations.TURNING:
			#$AnimationPlayer.play("turning")
		#Animations.DROOP:
			#$AnimationPlayer.play("droop")
		#Animations.EXIT_DROOP:
			#$AnimationPlayer.play("exit_droop")
		#Animations.CHARGE_ROAR:
			#$AnimationPlayer.play("turning")
		#Animations.ROARING:
			#$AnimationPlayer.play("turning")
		#Animations.IDLE_SWORD:
			#$AnimationPlayer.play("turning")
		#Animations.IDLE_NO_SWORD:
			#$AnimationPlayer.play("turning")
