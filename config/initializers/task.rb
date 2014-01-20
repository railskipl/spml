require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.new
scheduler.every("15d") do
    ReadingsController.do_something
end