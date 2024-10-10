function gui --wraps='sudo systemctl start gdm' --description 'alias gui sudo systemctl start gdm'
  sudo systemctl start gdm $argv
        
end
