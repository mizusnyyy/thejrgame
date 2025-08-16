extends Label
@export var t=true
func _on_ready() -> void:
	if t:
		timeset()
		return
	dateset()

func timeset():
	var time = Time.get_datetime_dict_from_system()
	var h = time.hour
	var m = time.minute
	var s = time.second
	text = "%02d:%02d" %[h,m]
	await get_tree().create_timer(60-s).timeout
	timeset()

func dateset():
	var time = Time.get_datetime_dict_from_system()
	var d = time.day
	var m = time.month
	var y = time.year
	text = "%02d.%02d.%d" %[d,m,y]
