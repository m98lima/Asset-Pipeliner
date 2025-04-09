extends MarginContainer

var modified_list: Label;
var untracked_list: Label;
var commit_message: String = "";

func _ready() -> void:
	modified_list = %"Modified files";
	untracked_list = %"Untracked files";

	var status_message: Array[String];
	OS.execute("git", ["status"], status_message, true);

	var trimmed_status_message = _trim_status_message(status_message[0])
	modified_list.text = trimmed_status_message[0];
	untracked_list.text = trimmed_status_message[1];


func _trim_status_message(original_message: String) -> Array[String]:
	var modified_files: String;
	var untracked_files: String;
	var temp_string = original_message.split("working directory)\n");

	if original_message.contains("Changes not staged"):
		temp_string = temp_string[1].split("\n\n");
		modified_files = temp_string[0]
	else:
		modified_files = "Nenhum arquivo modificado";

	if (original_message.contains("Untracked files")):
		temp_string = original_message.split("Untracked files:")
		temp_string = temp_string[1].split("will be committed)\n");
		temp_string = temp_string[1].split("\n\n");
		untracked_files = temp_string[0];
	else:
		untracked_files = "Nenhum arquivo novo";

	return [modified_files, untracked_files];


func _update_commit_message(new_message: String) -> void:
	commit_message = new_message;
	%"Commit button".button_disabled = commit_message == "";


func _commit_changes() -> void:
	var commit_output: Array[String];
	OS.execute("git", ["add", "."], commit_output, true);
	OS.execute("git", ['commit', '-m', commit_message], commit_output, true);
	OS.execute("git", ["push"])
	WindowTransitioner._transition_to(WindowNames.COMMIT_CHANGES);


func _refresh_files() -> void:
	WindowTransitioner._transition_to(WindowNames.COMMIT_CHANGES);
