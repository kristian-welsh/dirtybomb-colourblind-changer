require("FileUtils")

SEARCH_TAG1 = "[ShooterGame.SGUIHUDIFFObjectAlly]"

OLD_PRIMARY_COLOR = "R=0,G=150,B=200,A=255"
NEW_PRIMARY_COLOR = "R=50,G=255,B=50,A=255" 


username = "Hiccup"
CONFIG_PATH1 = "C:\\Users\\#{username}\\Documents\\My Games\\UnrealEngine3\\ShooterGame\\Config"
CONFIG_LOCATION1 = "#{CONFIG_PATH1}\\ShooterUI.ini" 
CONFIG_BACKUP1 = "#{CONFIG_PATH1}\\ShooterUI.ini.bak" 

CONFIG_LOCATION2 = 
  "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Dirty Bomb\\ShooterGame\\Config\\DefaultGame.ini"


FileUtils.rm CONFIG_LOCATION1
FileUtils.copy CONFIG_BACKUP1, CONFIG_LOCATION1

if File.exist? CONFIG_LOCATION1 
  FileUtils.copy CONFIG_LOCATION1, CONFIG_BACKUP1
  File.open(CONFIG_LOCATION1, 'w') {|file| file.truncate(0) }
end

def for_lines_containing contents, search_term
  lines_left = 0
  new_contents = ""

  contents.each_line do |line|
    if lines_left > 0
      puts line
      line = line.gsub(OLD_PRIMARY_COLOR, NEW_PRIMARY_COLOR)
      lines_left -= 1
    end

    if line.include? search_term
      lines_left += 1
    end

    new_contents = new_contents + line
  end
  new_contents
end

File.open(CONFIG_BACKUP1, "r") do |backup|
  File.open(CONFIG_LOCATION1, "r+") do |file|
    file.write(for_lines_containing(backup.read, SEARCH_TAG1))
  end
end
