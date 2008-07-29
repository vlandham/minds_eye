namespace :me do
  desc "Rsync the photos directory back to current computer"
  task :photo_sync do
    local_dir = "/Users/vlandham/Sites/minds_eye/public/images/"
    remote_dir = "/Users/vlandham/Sites/minds_eye/public/images/photos"
    `rsync -e "ssh" -rcaE --update --delete-after vlandham@192.168.1.3:#{remote_dir} #{local_dir} -v`
  end  
  task :database_sync do
    local_dir = "/Users/vlandham/Sites/minds_eye/db/production.sqlite3"
    remote_dir = "/Users/vlandham/Sites/minds_eye/db/development.sqlite3"
    `rsync -e "ssh" -rcaE --update --delete-after vlandham@192.168.1.3:#{remote_dir} #{local_dir} -v`
  end
  
  desc "Rsync the photos directory back to current computer"
  task :test_sync do
    local_dir = "/Users/vlandham/"
    remote_dir = "/Users/vlandham/Sites/minds_eye/public/images/icons"
    `rsync -e "ssh" -rcaE --update --delete-after vlandham@192.168.1.3:#{remote_dir} #{local_dir} -v`
  end
  
end