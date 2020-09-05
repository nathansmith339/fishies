extends StateMachine

var wander_timer : Timer
var rng : RandomNumberGenerator

func _ready() -> void:
    rng = RandomNumberGenerator.new()
    rng.randomize()

    parent = get_parent()

    add_state('wander')
    add_state('find_food')
    set_state('wander')

    wander_timer = Timer.new()
    add_child(wander_timer)
    wander_timer.wait_time = 2.0
    wander_timer.one_shot = true
    wander_timer.connect('timeout', self, 'set_wander_position')
    wander_timer.start()

func _process_state_logic(delta : float):
    match state:
        states.wander:
            if wander_timer.is_stopped():
                yield(get_tree().create_timer(rng.randi_range(0,3)), 'timeout')
                wander_timer.start()

        states.find_food:
            if parent.target:
                parent.destination = parent.target.position
            else:
                parent.find_food()

func set_wander_position():
    var min_range = Vector2(5, 5)
    var max_range = get_viewport().size - Vector2(32, 32)
    var random_position = Vector2(rng.randf_range(min_range.x, max_range.x), rng.randf_range(min_range.y, max_range.y))

    while((parent.position - random_position).length() < 5.0):
        random_position = Vector2(rng.randf_range(min_range.x, max_range.x), rng.randf_range(min_range.y, max_range.y))

    parent.destination = random_position
