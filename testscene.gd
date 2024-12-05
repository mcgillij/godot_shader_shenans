extends Node2D

@onready var color_rect_2: ColorRect = %ColorRect2
@onready var color_rect_3: ColorRect = $ColorRect3
@onready var color_rect_4: ColorRect = $ColorRect4
@onready var color_rect_5: ColorRect = $ColorRect5

var julia_a_values = [
	Vector2(0.285, 0.01),
	Vector2(-0.97, 0.66),
	Vector2(-0.7885, 0.1704),
	Vector2(-0.835, 0.2369)
]

var julia_b_values = [
	Vector2(0.01, 0.0),
	Vector2(0.01, 0.0),
	Vector2(0.186, 0.070),
	Vector2(-0.235, 0.2369)
]
var current_index = 0
var time_since_last_change = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	color_rect_2.get_material().set_shader_parameter("zoom", color_rect_2.get_material().get_shader_parameter("zoom") + 0.1 * delta)
	color_rect_3.get_material().set_shader_parameter("zoom", color_rect_3.get_material().get_shader_parameter("zoom") + 0.1 * delta)
	color_rect_4.get_material().set_shader_parameter("zoom", color_rect_4.get_material().get_shader_parameter("zoom") + 0.1 * delta)
	color_rect_5.get_material().set_shader_parameter("zoom_factor", color_rect_5.get_material().get_shader_parameter("zoom_factor") + 0.1 * delta)
	time_since_last_change += delta
	if time_since_last_change >= 1.0: # Change every second
		current_index = (current_index + 1) % julia_a_values.size()
		color_rect_5.get_material().set_shader_parameter("julia_a", julia_a_values[current_index])
		color_rect_5.get_material().set_shader_parameter("julia_b", julia_b_values[current_index].x)
		time_since_last_change -= 1.0
