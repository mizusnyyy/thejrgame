extends Area2D

@onready var anim = $item
@onready var label = $RichTextLabel
@onready var notui =  $".."

var selected = false
var interacting = false
var selected_item_index = 0

func _ready() -> void:
	label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("select")
		selected = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "soul":
		anim.play("default")
		selected = false
		interacting = false

func _process(_delta: float) -> void:
	if global.current_state == global.state.PLAYER_TURN:
		if interacting:
			if global.inventory.size() == 0:
				interacting = false
				label.visible = false
				return

			if Input.is_action_just_pressed("down"):
				selected_item_index = (selected_item_index + 1) % global.inventory.size()
				_show_items()
			elif Input.is_action_just_pressed("up"):
				selected_item_index = (selected_item_index - 1 + global.inventory.size()) % global.inventory.size()
				_show_items()
			elif Input.is_action_just_pressed("interact"):
				# Użyj itemu
				global.use_item(selected_item_index, "player")

				_show_items()

				if selected_item_index >= global.inventory.size():
					selected_item_index = max(0, global.inventory.size() - 1)

				notui.enemyturn()

		else:
			if Input.is_action_just_pressed("interact"):
				interacting = true
				label.visible = true
				selected_item_index = 0 #reset
				_show_items()

func _show_items() -> void:
	var text = "[center]"
	for i in range(global.inventory.size()):
		var item = global.inventory[i]
		if i == selected_item_index:
			text += "[color=yellow][b][url=item_%d]%s[/url][/b][/color]\n" % [i, item.name]
		else:
			text += "[url=item_%d]%s[/url]\n" % [i, item.name]
	text += "[/center]"
	label.text = text

func _on_label_meta_clicked(meta: Variant) -> void:
	if typeof(meta) == TYPE_STRING and meta.begins_with("item_"):
		var index = int(meta.substr(5))
		global.use_item(index, "player")
		_show_items()
		notui.enemyturn()
		interacting=!interacting
