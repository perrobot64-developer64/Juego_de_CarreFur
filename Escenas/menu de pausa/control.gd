extends Control

@onready var botones := $VBoxContainer.get_children()

func _ready():
	for boton in botones:
		boton.connect("mouse_entered", Callable(self, "_on_boton_hovered").bind(boton))
		boton.connect("mouse_exited", Callable(self, "_on_boton_exited").bind(boton))
		# Ajustar la línea blanca al tamaño y posición del botón
		var linea = boton.get_node("LineaSeleccion")
		linea.position = Vector2(0, boton.size.y - 3)  # 3 píxeles desde abajo
		linea.size = Vector2(boton.size.x, 3)  # ancho del botón, alto 3

func _on_boton_hovered(boton):
	var linea = boton.get_node("LineaSeleccion")
	linea.visible = true

func _on_boton_exited(boton):
	var linea = boton.get_node("LineaSeleccion")
	linea.visible = false
