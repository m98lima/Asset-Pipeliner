extends MarginContainer


func _ready() -> void:
	OS.execute("git", ["pull"]);

	var file = FileAccess.open(".gitignore", FileAccess.READ_WRITE);

	if (file == null):
		file = FileAccess.open(".gitignore", FileAccess.WRITE);

	var gitignore_contents = file.get_as_text();
	if !(gitignore_contents.contains("Pipeliner")):
		gitignore_contents += "\n\n*Asset Pipeliner*\n\n";
		file.store_string(gitignore_contents);

	file.close();

	$"VBoxContainer/Timer".start(.3);


func _timeout() -> void:
	$"VBoxContainer/HBoxContainer".visible = true;


func _next_window() -> void:
	var credentials = _check_user_credentials();
	if (credentials[0] == "" || credentials[1] == ""):
		WindowTransitioner._transition_to(WindowNames.CREDENTIALS_SETTER);
	else:
		WindowTransitioner._transition_to(WindowNames.COMMIT_CHANGES);



func _check_user_credentials() -> Array[String]:
	var user_name: String = "";
	var user_email: String = "";
	var arr: Array[String];

	OS.execute("git", ["config", "--list"], arr, true);
	var output: String = arr[0];
	var temp_string: String;

	if (output.contains("user.name")):
		temp_string = output.split("user.name=")[1];
		user_name = temp_string.split("\n")[0];

	if (output.contains("user.email")):
		temp_string = output.split("user.email=")[1];
		user_email = temp_string.split("\n")[0];

	return [user_name, user_email];
