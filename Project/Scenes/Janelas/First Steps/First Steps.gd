extends MarginContainer

var steps: Array
var current_step: int = 0;

func _ready() -> void:
	steps = get_children();

func _move_to_clone_repo() -> void:
	WindowTransitioner._transition_to(WindowNames.CLONE_REPO);

func _next_step() -> void:
	WindowTransitioner._play_window_animation();
	_change_step(1);

func _previous_step() -> void:
	WindowTransitioner._play_window_animation();
	_change_step(-1);

func _change_step(step_change: int) -> void:
	steps[current_step].visible = false;
	current_step += step_change;
	steps[current_step].visible = true;
