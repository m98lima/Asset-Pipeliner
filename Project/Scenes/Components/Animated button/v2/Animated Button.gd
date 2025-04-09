@tool
extends Button

signal inner_button_pressed;

@export var variation: button_types:
	set(value):
		variation = button_types.REFRESH;
		theme_type_variation = button_themes[variation];
		_set_params();

		variation = value;
		theme_type_variation = button_themes[variation];
		_set_params();
	get:
		return variation;
@export var button_text: String:
	set(value):
		text = value;
		if value == "":
			theme_type_variation = button_themes[button_types.REFRESH];
			_set_params();

			theme_type_variation = button_themes[variation];
			_set_params();

		_set_params();
	get:
		return text;
@export var button_disabled: bool:
	set(value):
		button_disabled = value;
		%"Button".disabled = value;
	get:
		return button_disabled;

var visible_button: Button
enum button_types {REGULAR, FORWARD, BACK, REFRESH}
var button_themes: Dictionary = {
	button_types.REGULAR: "",
	button_types.FORWARD: "ForwardButton",
	button_types.BACK: "BackButton",
	button_types.REFRESH: "RefreshButton",
};
var minimum_sizes: Dictionary = {
	"ForwardButton": Vector2(36,30),
	"BackButton": Vector2(36,30),
	"": Vector2(60,20),
	"RefreshButton": Vector2(50,60),
}


func _ready() -> void:
	visible_button = %"Button";
	_set_params();


func _set_params() -> void:
	if !(visible_button):
		return;

	custom_minimum_size = minimum_sizes[str(theme_type_variation)];
	set_size(custom_minimum_size)
	visible_button.custom_minimum_size = custom_minimum_size;
	visible_button.size = size;
	visible_button.text = text;
	visible_button.theme_type_variation = theme_type_variation;

	var pivot = $"Control" as Control;
	pivot.set_position(Vector2(size.x,size.y) / 2);
	visible_button.set_position(-Vector2(size.x,size.y) / 2);


func _press_button() -> void:
	$"AnimationPlayer".play("Button pressed");

func _release_button() -> void:
	$"AnimationPlayer".play("Button released");

func _emit_signal() -> void:
	inner_button_pressed.emit();
