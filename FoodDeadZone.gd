extends Area2D

func _ready():
    var vp_size = get_viewport_rect().size

    position = Vector2(vp_size.x / 2, vp_size.y)
    $CollisionShape2D.shape.set_extents(Vector2(vp_size.x, 10))

    connect('body_entered', self, '_on_food_entered')

func _on_food_entered(food):
    food.delete()
