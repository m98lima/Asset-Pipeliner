extends MarginContainer

@export var clone_button: Button;
var token: String = "";
var url: String = "";
var err_array: Array[String];

func _ready() -> void:
	clone_button.disabled = true;


func _update_token(new_token: String) -> void:
	token = new_token;
	_update_button_state();


func _update_url(new_url: String) -> void:
	url = new_url;
	_update_button_state()


func _update_button_state() -> void:
	clone_button.button_disabled = url == "" || token == "";


func _attempt_to_clone() -> void:
	var tokenized_url: String;
	tokenized_url = url.split("https://")[1];
	tokenized_url = "https://%s@%s" % [token, tokenized_url];

	OS.execute("git", ["clone", tokenized_url], err_array, true);
	if (err_array[0].contains("fatal")):
		OS.alert("Algo deu errado, tente novamente");
	else:
		WindowTransitioner._transition_to(WindowNames.REPO_CLONED);
