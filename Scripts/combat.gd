extends Control


@onready var enemy_label: Label = $EnemyPanel/EnemyLabel
@onready var player_hp_label: Label = $PlayerPanel/HBoxContainer/PlayerHPLabel
@onready var enemy_hp_label: Label = $PlayerPanel/HBoxContainer/EnemyHPLabel
@onready var message_label: Label = $MessagePanel/MessageLabel


@onready var attack_label: Label = $CommandPanel/HBoxContainer/AttackLabel
@onready var defend_label: Label = $CommandPanel/HBoxContainer/DefendLabel
@onready var run_label: Label = $CommandPanel/HBoxContainer/RunLabel

var battle_over := false
var battle_won := false


var player_maxHp := 30
var player_hp := 30
var player_attack_damage := 8


var enemy_name := "Goblin"
var enemy_max_hp := 20
var enemy_hp := 20
var enemy_attack_damage := 5


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
	if event.is_action_pressed("ui_accept") and battle_over:
		get_tree().change_scene_to_file("res://Scene/first_floor.tscn")
		return

	if battle_over:
		return

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

	if event.is_action_pressed("ui_accept"):
		_select_command()


func _update_status() -> void:
	enemy_hp_label.text = enemy_name + " HP: " + str(enemy_hp) + " / " + str(enemy_max_hp)
	player_hp_label.text = "Player HP: " + str(player_hp) + " / " + str(player_maxHp)


func _update_command_menu() -> void:
	for i in command_labels.size():
		if i == selected_command_index:
			command_labels[i].text = "> " + command_names[i] + " <"
		else:
			command_labels[i].text = command_names[i]


func _select_command() -> void:
	var selected_command = command_names[selected_command_index]
	
	if selected_command == "Attack":
		_player_attack()
	elif selected_command == "Defend":
		message_label.text = "Defend is not built yet."
	elif selected_command == "Run":
		message_label.text = "Run is not built yet."


func _player_attack() -> void:
	enemy_hp -= player_attack_damage

	if enemy_hp < 0:
		enemy_hp = 0

	message_label.text = "You attack the goblin for " + str(player_attack_damage) + " damage."
	_update_status()

	if enemy_hp <= 0:
		_win_battle()
		return

	_enemy_turn()


func _enemy_turn() -> void:
	player_hp -= enemy_attack_damage

	if player_hp < 0:
		player_hp = 0

	message_label.text += "\nThe goblin hits you for " + str(enemy_attack_damage) + " damage."
	_update_status()

	if player_hp <= 0:
		message_label.text += "\nYou were defeated..."


func _win_battle() -> void:
	battle_over = true
	battle_won = true
	
	Gamestate.fang += 1
	Gamestate.fought_floor_1 = true
	
	message_label.text += "\nThe golbin is defeated!"
	message_label.text += "\nYou found 1 Fang!"
	message_label.text += "\nPress confirm to return to Floor 1."


func _lose_battle() -> void:
	pass
