@tool
class_name CharacterContainer
extends Control

func on_child_entered_tree(node: Node):
	if node is CharacterControl:
		node.position = Vector2(size.x * .5, size.y)
	else:
		printerr("Node type %s should not be used" % [node.get_class()])

