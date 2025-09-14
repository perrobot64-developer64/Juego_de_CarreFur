extends ParallaxBackground

@export var scroll_speed: Vector2 = Vector2(0, 50)

func _process(delta: float):
	scroll_offset += scroll_speed * delta
