extends Control

@onready var explore_label: Label = $HBoxContainer/exploreLabel
@onready var rest_label: Label = $HBoxContainer/restLabel
@onready var craft_label: Label = $HBoxContainer/craftLabel
@onready var quit_label: Label = $HBoxContainer/quitLabel
@onready var message_label: RichTextLabel = $MessagePanel/VBoxContainer/MessageLabel

var labels: Array[Label] = []
var options := ["Explore", "Rest", "Craft", "Quit"]
var selected_index := 0


func _ready() -> void:
	labels = [
		explore_label,
		rest_label,
		craft_label,
		quit_label,
	]

	_update_menu()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		selected_index += 1
		if selected_index >= options.size():
			selected_index = 0
		_update_menu()

	if event.is_action_pressed("ui_left"):
		selected_index -= 1
		if selected_index < 0:
			selected_index = options.size() - 1
		_update_menu()

	if event.is_action_pressed("ui_accept"):
		_select_option()


func _update_menu() -> void:
	for i in labels.size():
		if i == selected_index:
			labels[i].text = "> " + options[i] + " <"
		else:
			labels[i].text = options[i]


func _select_option() -> void:
	var selected_option  = options[selected_index]

	if selected_option == "Explore":
		get_tree().change_scene_to_file("res://Scene/first_floor.tscn")

	elif selected_option == "Rest":
		message_label.text = "You rested. Nothing happens yet."

	elif selected_option == "Craft":
		if Gamestate.craft_dagger():
			message_label.text = "You crafted the D-Rank Dagger! Prototype complete!"
		else:
			message_label.text = "You need 1 Fang, 1 Silk and 2 Wood to craft a D-Rank Dagger."

	elif selected_option == "Quit":
		get_tree().quit()
