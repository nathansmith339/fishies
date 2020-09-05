extends Node2D

var FoodScene = preload('res://Food.tscn')
var FishieScene = preload('res://Fishie.tscn')
var rng : RandomNumberGenerator

var food_cooldown : Timer
var MAX_FOOD_COUNT = 6


func _ready() -> void:
    rng = RandomNumberGenerator.new()
    rng.randomize()

    food_cooldown = Timer.new()
    food_cooldown.wait_time = 0.20
    food_cooldown.one_shot = true
    food_cooldown.stop()
    add_child(food_cooldown)

    var num_fishies = 4
    var vp_size = get_viewport_rect().size

    for n in num_fishies:
        var new_fish = FishieScene.instance()
        var rng_x = rng.randi_range(5, vp_size.x - 5)
        var rng_y = rng.randi_range(5, vp_size.y - 5)
        new_fish.position = Vector2(rng_x, rng_y)
        new_fish.hunger = rng.randf_range(0.0, 66.0)

        add_child(new_fish)

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        var food_count = get_tree().get_nodes_in_group('food').size()
        if food_cooldown.is_stopped() and food_count <= MAX_FOOD_COUNT:
            spawn_food(get_global_mouse_position())

func spawn_food(location):
    var new_food = FoodScene.instance()
    new_food.position = location
    add_child(new_food)
    food_cooldown.start()

func _physics_process(delta: float) -> void:
    $FoodCount.text = str(get_tree().get_nodes_in_group('food').size())
