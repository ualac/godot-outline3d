tool
extends MeshInstance

func _ready() -> void:
	if Engine.editor_hint :
		visible = false
	else :
		visible = true
	
