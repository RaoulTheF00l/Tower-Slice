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
	pass # Replace with function body.
