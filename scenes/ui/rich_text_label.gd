extends RichTextLabel

func _process(_delta):
	# wymusza ciągły redraw, żeby efekty działały nawet po skipie
	queue_redraw()
