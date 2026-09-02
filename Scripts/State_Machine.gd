extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}


# initialization of all states assigned to this machine
func _ready():
	for child in get_children():
		if child is State:
			# add the state node to the dictionary
			states[child.name.to_lower()] = child
			# plug in it's signal used for when a state wants to change states
			child.Transition.connect(on_child_transition)
	
	# enter into the state assigned in the inspector (if it exisits)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
			
# if we are in a state, make it update
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

# if we are in a state, make it update (but physics this time)
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

# function for switching between states
func on_child_transition(state, requested_state_name):
	# deny if a state which is not the current state attempts to request a switch
	if state != current_state:
		return
	
	# fetch the state that was asked for
	var upcoming_state = states.get(requested_state_name.to_lower())
	# deny if it doesn't exist
	if !upcoming_state:
		return
	
	# escape from the current state
	if current_state:
		current_state.Exit()
	
	# enter into the requested state
	upcoming_state.Enter()
	current_state = upcoming_state
	
