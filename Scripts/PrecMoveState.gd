extends State
class_name PrecMoveState

@export var player : CharacterBody3D


func Enter():
	pass

func Exit():
	pass

#func Update(_delta: float):
	#pass

func Physics_Update(_delta: float):
	player.Physics_Update()

func User_Input(event: InputEvent):
	player.User_Input(event)
