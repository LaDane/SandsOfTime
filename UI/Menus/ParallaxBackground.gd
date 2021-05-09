extends ParallaxBackground

func _process(delta):
	$ParallaxLayer.motion_offset.x += -0.3
	$ParallaxLayer.motion_offset.y += 0.3
