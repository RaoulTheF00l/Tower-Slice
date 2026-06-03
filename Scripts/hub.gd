extends Control

@onready var explore_label: Label = $HBoxContainer/exploreLabel
@onready var rest_label: Label = $HBoxContainer/restLabel
@onready var craft_label: Label = $HBoxContainer/craftLabel
@onready var quit_label: Label = $HBoxContainer/quitLabel


var labels: Array[Label] = []
var options := ["Explore", "Rest", "Craft", "Quit"]
var selected_index := 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	labels = [
		explore_label,
		craft_label,
		rest_label,
		quit_label
	]
	
	_update_menu()


func _unhandled_input(event: InputEvent) -> void:
	pass


func _update_menu() -> void:
	for i in labels.size():
		if i == selected_index:
			labels[i].text = "> " + options[i] + " <"
		else:
			labels[i].text = options[i]


func _select_option() -> void:
	pass
