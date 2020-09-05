extends RigidBody2D

var food_amount : float = 50.0
var gravity : float = -24.8
var assigned = false

func _enter_tree() -> void:
    add_to_group('food')

func _ready():
    pass

func _physics_process(delta: float) -> void:
    var next_position = position - Vector2(0, gravity)
    position = lerp(position, next_position, delta)

func delete():
    remove_from_group('food')
    queue_free()
