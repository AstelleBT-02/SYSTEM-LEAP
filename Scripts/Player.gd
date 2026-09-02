extends CharacterBody3D

const SPEED = 1.0
const MAX_GROUND_SPEED = 3
const JUMP_VELOCITY = 10
const JUMP_DELAY_TIME = 15
const JUMP_CHARGE_RATE = 0.02
const MOUSE_SENS_HORIZONTAL = 5.0 / 1000
const MOUSE_SENS_VERTICAL = 5.0 / 1000
const JETPACK_MAX_FUEL = 200

func User_Input(event: InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENS_HORIZONTAL)
		$HeadPos/Camera3D.rotate_x(-event.relative.y * MOUSE_SENS_VERTICAL)
		#$HeadPos/Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(85), deg_to_rad(85))


func move():
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and velocity.length() < 3:
		velocity += direction * (SPEED * 1)
	
	move_and_slide()
		
func Physics_Update():
	move()
		
