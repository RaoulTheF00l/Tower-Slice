extends Node


var fangs:= 0
var wood:= 0
var rope:= 0


var fought_floor: bool = false
var foraged_floor: bool = false



func reset_run() -> void:
	fangs = 0
	wood - 0
	rope = 0
	
	
	fought_floor = false
	foraged_floor = false


func can_craft_dagger() -> void:
	if fangs >= 2 and wood >= 2 and rope >= 3:
		craft_dagger()
	else: print("Not Enough materials0")


func craft_dagger() -> void:
		fangs - 2
		wood - 1
		rope - 3
		
		print("You have crafted a D-Rank Dagger! End of prototype!")
		
