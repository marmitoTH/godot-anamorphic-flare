extends Node

export(float, 0.0, 1.0) var threshold := 0.8 setget set_threshold
export(float, 0.0, 1.0) var intensity := 0.5 setget set_intensity
export(Color) var tint := Color(0.5, 0.5, 0.5, 1.0) setget set_tint

var screen := MeshInstance.new()
var material := preload('anamorphic_flare.material').duplicate()

func _init() -> void:
	screen.mesh = CubeMesh.new()
	screen.scale = Vector3.ONE
	screen.material_override = material
	add_child(screen)

func set_threshold(value: float) -> void:
	threshold = value
	material.set_shader_param('THRESHOLD', threshold)

func set_intensity(value: float) -> void:
	intensity = value
	material.set_shader_param('INTENSITY', intensity)

func set_tint(value: Color) -> void:
	tint = value
	material.set_shader_param('TINT', tint)
