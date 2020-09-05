extends Area2D

func search():
    var result = []
    var close_foods = get_overlapping_bodies()

    for food in close_foods:
        if food.assigned == false:
            result.append(food)

    var all_foods = get_tree().get_nodes_in_group('food')
    for food in all_foods:
        if result.has(food) == false:
            result.append(food)

    return result

