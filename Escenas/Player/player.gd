extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002

@onready var camera: Camera3D = $Camera3D

var rotation_y := 0.0  # Yaw (izquierda/derecha)
var rotation_x := 0.0  # Pitch (arriba/abajo)

func _ready() -> void:
	# Captura el mouse al iniciar
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Rotación horizontal al cuerpo (yaw)
		rotation_y -= event.relative.x * MOUSE_SENSITIVITY
		rotation_degrees.y = rad_to_deg(rotation_y)

		# Rotación vertical a la cámara (pitch)
		rotation_x = clamp(rotation_x - event.relative.y * MOUSE_SENSITIVITY, deg_to_rad(-80), deg_to_rad(80))
		camera.rotation.x = rotation_x

	# Liberar mouse con Escape
	if event.is_action_pressed("ui_cancel"): # Escape por defecto es ui_cancel
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
