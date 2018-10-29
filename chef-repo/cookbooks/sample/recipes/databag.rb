data = data_bag_item('sample', 'DevOps')

log "Classroom Info" do 
  level :fatal
  message "Course Name #{data['id']} from Trainer #{data['Trainer']} and the timings are #{data['timings']} and mode of training is #{data['mode']}"
end
