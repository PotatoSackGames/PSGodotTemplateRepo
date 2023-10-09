extends Node

# Saves data to user://data for you automatically; probably doesn't work with web exports,
# since they don't have access to the main file system, but it might be possible to make it
# work


# Purely to cache the files that have been loaded already. Note: reload_data will attempt to reload the file
# that already exists; this makes it so you can save stuff at any point and then update it so that you always
# have the most recent data, regardless of whether or not it's cached
var Data = {}

const FilePrefix = "user://data/"
const FileSuffix = ".json"

func _ready():
	if not DirAccess.dir_exists_absolute(FilePrefix):
		DirAccess.make_dir_absolute(FilePrefix)

func reload_data(file_name):
	var file = FileAccess.open(FilePrefix + file_name + FileSuffix, FileAccess.READ)
	var result = JSON.parse_string(file.get_as_text())
	Data[file_name] = result
	return result

func get_data(file_name):
	if Data.has(file_name):
		return Data[file_name]
	else:
		if not file_exists(file_name):
			return null

		return reload_data(file_name)
		
func save_data(file_name, data):
	var file = FileAccess.open(FilePrefix + file_name + FileSuffix, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

func file_exists(file_name) -> bool:
	return FileAccess.file_exists(FilePrefix + file_name + FileSuffix)
