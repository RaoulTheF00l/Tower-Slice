extends Node

var fang := 0
var silk := 0
var wood := 0

var fought_floor_1 := false
var foraged_floor_1 := false
var dagger_crafted := false


func reset_run() -> void:
	fang = 0
	silk = 0
	wood = 0
	fought_floor_1 = false
	foraged_floor_1 = false
	dagger_crafted = false


func can_craft_dagger() -> bool:
	return fang >= 1 and silk >= 1 and wood >= 2 and not dagger_crafted


func craft_dagger() -> bool:
	if not can_craft_dagger():
		return false

	fang -= 1
	silk -= 1
	wood -= 2
	dagger_crafted = true
	return true
