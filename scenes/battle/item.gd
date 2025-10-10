extends Area2D

@onready var anim = $item
@onready var label = $RichTextLabel
@onready var notui = $".."
@onready var soul = $"../../soul"

var selected = false
var interacting = false
var selected_item_index = 0

func _ready() -> void:
	label.visible = false
	label.connect("meta_clicked", Callable(self, "_on_label_meta_clicked"))

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		if selected:
			hideall()
		else:
			selected = true
			anim.play("select")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "soul":
		pass
func _process(_delta: float) -> void:
	if selected and Global.current_state == Global.state.PLAYER_TURN:
		if interacting:
			if Global.inventory.size() == 0:
				interacting = false
				label.visible = false
				return

			if Input.is_action_just_pressed("down"):
				selected_item_index = (selected_item_index + 1) % Global.inventory.size()
				_show_items()
			elif Input.is_action_just_pressed("up"):
				selected_item_index = (selected_item_index - 1 + Global.inventory.size()) % Global.inventory.size()
				_show_items()
			elif Input.is_action_just_pressed("interact"):
				Global.use_item(selected_item_index, "player")
				Global.mana += 10
				hideall()

				_show_items()

				if selected_item_index >= Global.inventory.size():
					selected_item_index = max(0, Global.inventory.size() - 1)

				notui.enemyturn()

		else:
			if Input.is_action_just_pressed("interact") or selected:
				interacting = true
				label.visible = true
				selected_item_index = 0 #reset wyboru
				_show_items()

func _show_items() -> void:
	var text = ""
	for i in range(Global.inventory.size()):
		var item = Global.inventory[i]
		if i == selected_item_index:
			text += "[color=yellow]%s[/color]\n" % item.name
		else:
			text += "%s\n" % item.name
	label.text = text


func _on_label_meta_clicked(meta: Variant) -> void:
	if typeof(meta) == TYPE_STRING and meta.begins_with("item_"):
		var index = int(meta.substr(5))
		Global.use_item(index, "player")
		_show_items()
		notui.enemyturn()

func hideall():
	selected = false
	anim.play("default")
	interacting = false
	label.visible = false
