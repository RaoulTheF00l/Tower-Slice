 

extends Control

@onready var fight_label: Label = $Panel/HBoxContainer/fightLabel
@onready var forage_label: Label = $Panel/HBoxContainer/forageLabel
@onready var return_label: Label = $Panel/HBoxContainer/returnLabel
@onready var message_label: RichTextLabel = $Panel2/messageLabel


var labels: Array[Label] = []
var options := ["Fight", "Forage", "Return"]
var selected_index := 0


func _ready() -> void:
	labels = [
		fight_label,
		forage_label,
		return_label,
	]

	message_label.text = "Floor 1. A weak goblin is nearby. Useful materials are scattered around."
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
	var selected_option = options[selected_index]

	if selected_option == "Fight":
		_fight_enemy()

	elif selected_option == "Forage":
		_forage_materials()

	elif selected_option == "Return":
		get_tree().change_scene_to_file("res://Scene/hub.tscn")


func _fight_enemy() -> void:
	if Gamestate.fought_floor_1:
		message_label.text = "The goblin is already defeated."
		return

	get_tree().change_scene_to_file("res://Scene/combat.tscn")

	Gamestate.fang += 1
	Gamestate.fought_floor_1 = true
	message_label.text = "You fought a goblin and won!\nYou found 1 Fang."


func _forage_materials() -> void:
	if Gamestate.foraged_floor_1:
		message_label.text = "You already gathered the useful materials here."
		return

	Gamestate.silk += 1
	Gamestate.wood += 2
	Gamestate.foraged_floor_1 = true
	message_label.text = "You foraged the area.\nYou found 1 Silk and 2 Wood."
