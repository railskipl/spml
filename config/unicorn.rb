
#root = "/home/root/apps/meter-reading/current"
#root = "/meter-reading/spml/config"
#working_directory root
#pid "#{root}/tmp/pids/unicorn.pid"
#stderr_path "#{root}/log/unicorn.log"
#stdout_path "#{root}/log/unicorn.log"

#listen "/tmp/unicorn.blog.sock"
#worker_processes 2
#timeout 30



 listen 3001, :tcp_nopush => false



