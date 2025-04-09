extends MarginContainer


func _move_to_clone_repo() -> void:
	WindowTransitioner._transition_to(WindowNames.CLONE_REPO);

func _move_to_first_steps() -> void:
	WindowTransitioner._transition_to(WindowNames.FIRST_STEPS);
