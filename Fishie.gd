extends KinematicBody2D

var hunger : float
var MIN_HUNGER : float = 0.0
var MAX_HUNGER : float = 100.0
var HUNGER_THRESHOLD : float = 66.0

var speed : float = 80.0
var velocity : Vector2
var target : Node2D
var destination : Vector2 setget set_destination

func set_destination(value):
    destination = value

var FoodFinder
var FeedingRange


func _ready():
    FoodFinder = $FoodFinder
    FeedingRange = $FeedingRange

    FeedingRange.connect('body_entered', self, 'try_eating')

func _physics_process(delta):
    velocity = Vector2.ZERO
    var dist = destination - position

    if dist.length() > 5.0:
        velocity = dist.normalized() * speed

    velocity = move_and_slide(velocity)

    hunger += delta * 4

    if is_hungry():
        $MovementStateMachine.set_state('find_food')

    $StateLabel.text = $MovementStateMachine.get_current_state_name()
    $Hunger.text = str(round(hunger))

func find_food():
    var foods = FoodFinder.search()

    while foods.size() > 1:
        var new_target = foods.pop_back()
        if new_target.assigned == false:
            target = new_target
            target.assigned = true


func is_hungry() -> bool:
    return hunger > HUNGER_THRESHOLD

func eat(amount_fed : float):
    hunger -= amount_fed
    hunger = max(hunger, MIN_HUNGER)
    $MovementStateMachine.set_state('wander')

func try_eating(food : Node2D):
    if is_hungry():
        eat(food.food_amount)
        food.delete()
