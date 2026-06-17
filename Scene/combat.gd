extends Control


@onready var enemy_label: Label = $EnemyPanel/EnemyLabel
@onready var player_hp_label: Label = $PlayerPanel/HBoxContainer/PlayerHPLabel
@onready var enemy_hp_label: Label = $PlayerPanel/HBoxContainer/EnemyHPLabel
@onready var message_label: Label = $MessagePanel/MessageLabel


@onready var attack_label: Label = $CommandPanel/HBoxContainer/AttackLabel
@onready var defend_label: Label = $CommandPanel/HBoxContainer/DefendLabel
@onready var run_label: Label = $CommandPanel/HBoxContainer/RunLabel


var player_maxHp := 30
var player_hp := 30


var enemy_name := "Goblin"
var enemy_max_hp := 20
var enemy_hp := 20


var command_labels: Array[Label] = []
var command_names := ["Attack", "Defend", "Run"]
var selected_command_index := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	command_labels = [
		attack_label,
		defend_label,
		run_label
	]
	
	enemy_label.text = enemy_name
	message_label.text = "A Weak Goblin Blocks Your Path."
	_update_status()
	_update_command_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		selected_command_index += 1

		if selected_command_index >= command_names.size():
			selected_command_index = 0

		_update_command_menu()

	if event.is_action_pressed("ui_left"):
		selected_command_index -= 1

		if selected_command_index < 0:
			selected_command_index = command_names.size() - 1

		_update_command_menu()



func _update_status() -> void:
	enemy_hp_label.text = enemy_name + " HP: " + str(enemy_hp) + " / " + str(enemy_max_hp)
	player_hp_label.text = "Player HP: " + str(player_hp) + " / " + str(player_maxHp)


func _update_command_menu() -> void:
	for i in command_labels.size():
		if i == selected_command_index:
			command_labels[i].text = "> " + command_names[i] + " <"
		else:
			command_labels[i].text = command_names[i]
