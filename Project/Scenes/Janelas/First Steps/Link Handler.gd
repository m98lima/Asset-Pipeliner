extends HBoxContainer

@export var link: String;

func _open_link() -> void:
	OS.shell_open(link);

func _copy_link() -> void:
	DisplayServer.clipboard_set(link);
