extends Node2D

func intro():
	$Hover.hovering = true
	$Hover/Knight.after_image_speeds.x = 2
	$Hover/Knight.after_image_speeds.y = 0
	$AnimationPlayer.play("idle_aura_farming")
	await get_tree().create_timer(5.0).timeout
	
	$AnimationPlayer.play("turning")
	await get_tree().create_timer(3.0).timeout
	
	$AnimationPlayer.play("droop")
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("exit_droop")
	await get_tree().create_timer(1.2).timeout
	
	$Hover.shaking = true
	$Hover.hovering = false
	$Hover/Knight.whiten = true
	$AudioStreamPlayer.stream = await preload("res://monsters/roaringknight/res/snd_knight_stretch.wav")
	$Hover/Knight.enable_after_image = false;
	$AnimationPlayer.play("charge_roar")
	await get_tree().create_timer(0.5).timeout
	$AudioStreamPlayer.play()
	await get_tree().create_timer(2.53).timeout
	$Hover/Knight.whiten = false
	$Hover.shaking = false
	
	$AudioStreamPlayer.stream = await preload("res://monsters/roaringknight/res/snd_roaringknight_roar.wav")
	$Hover/Knight.after_image_speeds.y = $Hover/Knight.after_image_speeds.x
	$Hover/Knight.enable_after_image = true;
	$Hover/Knight.spawn_circle()
	$AnimationPlayer.play("roar")
	$AudioStreamPlayer.play()
	await get_tree().create_timer(5).timeout
	$Hover/Knight.remove_circle()
	
	$Hover.hovering = true
	$Hover/Knight.after_image_speeds.y = 0
	$AnimationPlayer.play("sword_appear")
	await get_tree().create_timer(1).timeout
	$Hover/Sword.appear()
	await get_tree().create_timer(0.5).timeout
	
	$AudioStreamPlayer.stream = await preload("res://globals/sounds/music/snd_weaponpull.wav")
	$AnimationPlayer.play("equip_sword")
	await get_tree().create_timer(1.2).timeout
	$Hover/Sword.visible = false
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.8).timeout

	$AudioStreamPlayer.stream = await preload("res://globals/sounds/music/mus_black_knife.ogg")
	$AnimationPlayer.play("idle_sword")
	$AudioStreamPlayer.play()	
	$AnimationPlayer.stop()


func _ready():
	intro()
	pass
