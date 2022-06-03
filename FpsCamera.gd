extends Camera

var MAX_CAM_ROTATE_X := deg2rad( 65.0 )
var MIN_CAM_ROTATE_X := deg2rad( -65.0 )
var MOVE_SPEED := 10.0


func _ready() -> void:
	# capture keeps the mouse position at the centre
	# and allows continuous relative event updates
	Input.set_mouse_mode( Input.MOUSE_MODE_CAPTURED ) 


func _process(delta: float) -> void:
	# get input info
	var _forward_dir := Vector3(0.0, 0.0, -1.0).rotated( Vector3.UP, rotation.y )
	var _strafe_dir := Vector3(1.0, 0.0, 0.0).rotated( Vector3.UP, rotation.y )

	_forward_dir *= Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward");
	_strafe_dir *= Input.get_action_strength("move_right") - Input.get_action_strength("move_left");

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED :
		translation += (_forward_dir+_strafe_dir).normalized() * MOVE_SPEED * delta


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed :
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED :
			Input.set_mouse_mode( Input.MOUSE_MODE_VISIBLE )	
		else :
			Input.set_mouse_mode( Input.MOUSE_MODE_CAPTURED ) 

	# only perform movement in capture mode
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED :
		if event is InputEventMouseMotion :
			var _mouse_move = event.relative
			var _cam_rotate_x := rotation.x
			var _cam_rotate_y := rotation.y
			_cam_rotate_x += -deg2rad( _mouse_move.y * 0.1 )
			_cam_rotate_y += -deg2rad( _mouse_move.x * 0.1 )
			
			if _cam_rotate_x > MAX_CAM_ROTATE_X :
				_cam_rotate_x = MAX_CAM_ROTATE_X
			if _cam_rotate_x < MIN_CAM_ROTATE_X :
				_cam_rotate_x = MIN_CAM_ROTATE_X	
				
			rotation = Vector3( _cam_rotate_x, _cam_rotate_y, 0.0 )	 
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE :
		if event is InputEventMouseButton and event.pressed :
			Input.set_mouse_mode( Input.MOUSE_MODE_CAPTURED ) 
