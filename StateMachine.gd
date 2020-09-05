extends Node
class_name StateMachine

var state = null setget set_state
var previous_state = null
var parent : Node = null

var states : Dictionary = {}

### BEGIN VIRTUAL METHODS

func _process_state_logic(delta):
    pass

func _get_transition(delta):
    return null

func _enter_state(new_state, old_state):
    pass

func _exit_state(old_state, new_state):
    pass

### END VIRTUAL METHODS

func _ready():
    parent = get_parent()

func _physics_process(delta):
    if state == null: return
    _process_state_logic(delta)

    var transition = _get_transition(delta)
    if transition == null: return
    set_state(transition)

func set_state(new_state):
    if new_state is String:
        new_state = states[new_state]

    previous_state = state
    state = new_state

    if previous_state != null:
        _exit_state(previous_state, new_state)
    if new_state != null:
        _enter_state(new_state, previous_state)

func add_state(state_name : String):
    states[state_name] = states.size()

func get_state_name(state_num : int = 0):
    if state_num >= 0 and state_num < states.size():
        return states.keys()[state_num]

    return null

func get_current_state_name() -> String:
    return get_state_name(state)

