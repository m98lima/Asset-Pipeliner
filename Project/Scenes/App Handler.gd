extends CanvasLayer


func _ready() -> void:
	WindowTransitioner._assign_main_panel(%"Main panel");
	WindowTransitioner._assign_animation_player(%"AnimationPlayer");

	var err_log: Array[String];
	OS.execute("git", ["status"], err_log, true);

	if (err_log[0].contains("fatal")):
		WindowTransitioner._transition_to(WindowNames.NOT_A_REPO);
	else:
		WindowTransitioner._transition_to(WindowNames.PLEASE_WAIT);
