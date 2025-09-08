extends CanvasLayer

@onready var panel: Control = $Control
@onready var fondo: ColorRect = $ColorRect
var tween: Tween

func _ready():
	panel.visible = false
	fondo.visible = true
	fondo.color.a = 0.0

func _unhandled_input(event):
	if event.is_action_pressed("pause"): 
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		# Quitar pausa
		get_tree().paused = false
		panel.visible = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		fade_to(0.0)
	else:
		# Activar pausa
		get_tree().paused = true
		panel.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		fade_to(0.5)

func fade_to(alpha: float):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_process_mode(Tween.TweenProcessMode.TWEEN_PROCESS_IDLE)
	tween.tween_property(fondo, "color:a", alpha, 0.3)

# Función conectada al botón "Continuar"
func _on_BotonContinuar_pressed():
	if get_tree().paused:
		toggle_pause()


func _on_continuar_pressed() -> void:
	_on_BotonContinuar_pressed()
