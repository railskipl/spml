require 'rubygems'
require 'rufus/scheduler'  
scheduler = Rufus::Scheduler.new
scheduler.every("30d") do
    ReadingsController.do_something
end
