extends MarginContainer

var user_name: String = "";
var user_email: String = "";
var button: Button;

func _ready() -> void:
	button = %"Configure button";
	button.disabled = true;


func _update_name(new_name: String) -> void:
	user_name = new_name;
	_check_inputs();

func _update_email(new_email: String) -> void:
	user_email = new_email;
	_check_inputs();


func _check_inputs() -> void:
	var are_inputs_missing = (user_name == "" || user_email == "");
	button.button_disabled = are_inputs_missing;


func _submit_credentials() -> void:
	var output_arr: Array[String];
	OS.execute("git", ["config", "--local", "user.name", user_name], output_arr, true);
	print(output_arr[0]);
	OS.execute("git", ["config", "--local", "user.email", user_email], output_arr, true);
	print(output_arr[0]);

	WindowTransitioner._transition_to(WindowNames.COMMIT_CHANGES);
