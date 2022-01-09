extends Camera

export(float) var speed := 0.1

func _process(delta):
	rotate_y(speed * delta)
