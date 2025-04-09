extends Control

@onready var main_panel: PanelContainer = %"Main Panel";
@onready var side_panel: PanelContainer = %"Side Panel";
var is_side_panel_open: bool = false;

func _shake_screen() -> void:
	var tween = create_tween();
	tween.tween_property(main_panel, "position", main_panel.position + Vector2(15, 0), .1);
	tween.tween_property(main_panel, "position", main_panel.position + Vector2(-30, 0), .1);
	tween.tween_property(main_panel, "position", main_panel.position + Vector2(30, 0), .1);
	tween.tween_property(main_panel, "position", main_panel.position + Vector2(-30, 0), .1);
	tween.tween_property(main_panel, "position", main_panel.position, .1);
	#$"AnimationPlayer".play("Shake window")


func _open_side_panel() -> void:
	if (!is_side_panel_open):
		side_panel.visible = true;
		var tween = create_tween();
		tween.tween_property(side_panel, "scale", Vector2(1,1), .1);
		is_side_panel_open = true;
	else:
		var tween = create_tween();
		tween.tween_property(side_panel, "scale", Vector2(.1,.7), .1);
		tween.finished.connect(func():
			side_panel.visible = false;
			is_side_panel_open = false;
		)


func _spin_panel() -> void:
	$"AnimationPlayer".play("Spin Panel");
