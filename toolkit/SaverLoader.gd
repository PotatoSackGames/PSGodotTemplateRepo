extends Node

var Data = {}

const FilePrefix = "user://data/"
const FileSuffix = ".json"

func _ready():
	if not DirAccess.dir_exists_absolute(FilePrefix):
		DirAccess.make_dir_absolute(FilePrefix)

func get_data(file_name):
	if Data.has(file_name):
		return Data[file_name]
	else:
		if not file_exists(FilePrefix + file_name + FileSuffix):
			return null

		var file = FileAccess.open(FilePrefix + file_name + FileSuffix, FileAccess.READ)
		var result = JSON.parse_string(file.get_as_text())
		Data[file_name] = result
		return result
		
func save_data(file_name, data):
	var file = FileAccess.open(FilePrefix + file_name + FileSuffix, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func file_exists(file_name) -> bool:
	return FileAccess.file_exists(FilePrefix + file_name + FileSuffix)
