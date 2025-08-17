extends MarginContainer

@export var enabled : bool = true

enum DISPLAY_TYPE{
	STRING,
	LENGTH,
	ROUND
}

class Property:
	var num_format = "%4.2f"
	var object
	var property
	var label_ref
	var display: DISPLAY_TYPE
	var enabled = true
	
	func _init(_object, _property, _label, _display: DISPLAY_TYPE, _enabled=true):
		object = _object
		property = _property
		label_ref = _label
		display = _display
		enabled = _enabled
		
		
	func set_label():
		if(not enabled): return
		var s = object.name + "/" + property + " : "
		var p = object.get_indexed(property)
		
		match display:
			DISPLAY_TYPE.STRING:
				s += str(p)
			DISPLAY_TYPE.LENGTH: 
				s += num_format % p.length()
			DISPLAY_TYPE.ROUND:
				match typeof(p):
					TYPE_INT, TYPE_FLOAT:
						s += num_format % p
					TYPE_VECTOR2, TYPE_VECTOR3:
						s += str(p.round())
		label_ref.text = s

var props: Array[Property] = []
var debug_overlay: Node

func _process(delta: float) -> void:
	if not visible or not enabled:
		return 
	
	for prop in props:
		prop.set_label()

func add_property(object, property: String, display: DISPLAY_TYPE):
	if(not debug_overlay):
		print("Debug Overlay not found", debug_overlay)
		return
	var label = Label.new()
	debug_overlay.get_node("VBoxContainer").add_child(label)
	props.append(Property.new(object, property, label, display, enabled))

func remove_property(object, property):
	for prop in props:
		if(prop.object == object and prop.property == property):
			props.erase(prop)

func setup_debugger(node):
	debug_overlay = node
	
# How to use -

# add this in the main game script
#func _enter_tree() -> void:
#	DebugOverlay.setup_debugger($DebugOverlay)
	
#	Then you can register like this
#DebugOverlay.add_property(self, "velocity", DebugOverlay.DISPLAY_TYPE.ROUND)
