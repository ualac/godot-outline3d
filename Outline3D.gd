extends Spatial

# provide some functionality to randomly assign objects to the outline
# cull layer when the spacebar is pressed

onready var TheObjects := [ $SphereMeshA, $SphereMeshB, $CubeMeshA ]

# this will set the first bit of the layer mask == layer 2
var OUTLINE_CULL_LAYER_BIT = 1 

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.pressed and event.scancode == KEY_SPACE :
		# for each object randomly add/remove from outline cull layer
		# any geometry placed on cull layer 2 wll be rendered with an outline
		# as the camera for the Outline Viewport is set to only render this layer
		for obj in TheObjects :
			obj.set_layer_mask_bit( OUTLINE_CULL_LAYER_BIT, bool( randi() % 2 ))

