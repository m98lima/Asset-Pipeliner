extends Control

@onready var anim_player = $"AnimationPlayer";
@onready var button: Button = %"Button";
@onready var button2: Button = %"Button2";
@export var button_text: String = ""
@export var dale: button_types;
enum button_types {REGULAR, FORWARD_ARROW, BACK_ARROW, REFRESH};
var button_variations: Dictionary = {
	button_types.REGULAR: "",
	button_types.FORWARD_ARROW: "ForwardButton",
	button_types.BACK_ARROW: "BackButton",
	button_types.REFRESH: "RefreshButton",
}
var button_sizes: Dictionary = {
	button_types.REGULAR: Vector2(60,20),
	button_types.FORWARD_ARROW: Vector2(36,30),
	button_types.BACK_ARROW: Vector2(36,30),
	button_types.REFRESH: Vector2(40,40),
}

func _ready() -> void:
	button.theme_type_variation = button_variations[dale];
	button2.theme_type_variation = button_variations[dale];
	button.size = button_sizes[dale];
	button2.size = button_sizes[dale];
	button.text = button_text;
	button2.text = button_text;
	#button2.anchor
	button2.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
	#print(button2.theme.get_type_list());

func _press_button() -> void:
	anim_player.play("Button press");

func _release_button() -> void:
	anim_player.play("Button release");
