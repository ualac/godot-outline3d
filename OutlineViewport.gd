extends Viewport

func _ready() -> void:
	match_root_viewport()
	# track root viewport size changes
	var _u = get_tree().get_root().connect( "size_changed", self, "match_root_viewport" )

func match_root_viewport() -> void:
	# scale our size to match the root viewport exactly
	size = get_tree().get_root().size

