extends Camera2D

export(float) var speed;
var dir : Vector2 = Vector2();
var velocity: Vector2 = Vector2();
func _ready():
	get_node("ColorRect").margin_left *= zoom.x; 
	get_node("ColorRect").margin_right *= zoom.x;
	get_node("ColorRect").margin_top *= zoom.y; 
	get_node("ColorRect").margin_bottom *= zoom.y; 
func _process(delta):
	_camera(delta);
func _camera(delta:float):
	_movement();
	velocity = velocity.linear_interpolate(dir*speed*scale,delta*10)
	global_position = global_position+velocity;
func _movement():
	dir.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"));
	dir.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"));
