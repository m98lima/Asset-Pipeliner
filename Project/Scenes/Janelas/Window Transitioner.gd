extends Node

signal transitioning;

var main_panel: PanelContainer;
var animator_main_panel: AnimationPlayer;
var current_window: MarginContainer = null;
var base_window_path: String = "res://Scenes/Janelas/";
var windows: Dictionary = {
	WindowNames.CLONE_REPO: "Clone repo/Clone repo scene.tscn",
	WindowNames.NOT_A_REPO: "Not a git repo/Not a git repo.tscn",
	WindowNames.REPO_CLONED: "Repo cloned/Repo cloned scene.tscn",
	WindowNames.COMMIT_CHANGES: "Commit Changes/Commit Changes.tscn",
	WindowNames.PLEASE_WAIT: "Please Wait/Please Wait.tscn",
	WindowNames.CREDENTIALS_SETTER: "Credentials Setter/Credentials Setter.tscn",
	WindowNames.FIRST_STEPS: "First Steps/First Steps.tscn",
};


func _assign_main_panel(panel: PanelContainer) -> void:
	main_panel = panel;
	if main_panel.get_child_count() > 0:
		current_window = main_panel.get_child(0);

func _assign_animation_player(anim_player: AnimationPlayer) -> void:
	animator_main_panel = anim_player;

func _play_window_animation() -> void:
	animator_main_panel.play("Switch screens");


func _transition_to(window_name: int) -> void:
	_play_window_animation();

	if current_window:
		current_window.queue_free();

	var window_path = base_window_path + windows[window_name];
	var new_window = load(window_path).instantiate();
	main_panel.add_child(new_window);
	current_window = new_window;
