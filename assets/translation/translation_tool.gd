@tool
extends EditorScript
# Exemplo de como tá o csv agora:
#Implemented?,Upgrade,Title,Título,Description,Descrição,Tooltip
#FALSE,ball_add, +1 Ball, +1 Bola,More balls is more better.,Mais Bolas é mais melhor.,"Balls are really motivated to kill you, but they lack a clear sense of direction in life. Currently adding +X balls."

func _run() -> void:
	var output_file = FileAccess.open("res://assets/translation/translation.csv", FileAccess.WRITE)
	var file := FileAccess.open("res://assets/translation/Incremental Game Upgrades - Página1.csv", FileAccess.READ)
	if file == null:
		push_error("GG Errou o arquivo de CSV ou deu outro problema foda: %s" % FileAccess.get_open_error())
		return
		
	var _header = file.get_csv_line()
	
	output_file.store_csv_line(["keys", "en", "pt"])
	
	while file.get_position() < file.get_length():
		var line := file.get_csv_line()
		if line[2] == "": continue # Omitting empty lines
		
		var base_key := line[1]
		
		output_file.store_csv_line(["%s_title" % base_key, line[2], line[3]])
		output_file.store_csv_line(["%s_description" % base_key, line[4], line[5]])
	
