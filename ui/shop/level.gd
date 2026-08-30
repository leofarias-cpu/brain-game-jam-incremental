extends RichTextLabel

var level = 0

func _on_shop_row_bought(upgrade: Upgrade) -> void:
	visible = true
	level += 1
	
	if level == upgrade.max_upgrades:
		level = "Max"
		
	self.text = "Level .%s" % level
