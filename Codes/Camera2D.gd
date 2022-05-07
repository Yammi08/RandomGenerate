extends Camera2D

export(float) var speed;
var dir : Vector2 = Vector2();
func _process(delta):
	_camera(delta);
func _camera(delta:float):
	_movement();
	global_position = global_position.linear_interpolate(global_position+(dir*speed),0.1*delta)
func _movement():
	dir.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"));
	dir.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"));
